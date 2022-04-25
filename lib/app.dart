import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ms/core/auth/auth_bloc/auth_bloc.dart';
import 'package:ms/core/service/authentication_repository.dart';
import 'package:ms/view/home/home.dart';
import 'package:ms/view/start/splash.dart';

import 'core/app/intl.dart';
import 'mystore.dart';
import 'view/widgets/widget.dart';

class MyApp extends MSStatelessWidget {
  MyApp({required this.authenticationRepository, Key? key}) : super(key: key);

  final AuthenticationRepository authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: authenticationRepository,
        child: BlocProvider(
          create: (_) => AuthenticationBloc(
              authenticationRepository: authenticationRepository),
          child: AppView(),
        ));
  }
}

class AppView extends MSStatefulWidget {
  AppView({Key? key}) : super(key: key);

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends MSState<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: kBackgroundColor),
        appBarTheme: AppBarTheme(backgroundColor: kBackgroundColor),
      ),
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  HomePage.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  ScreenPage.route(),
                  (route) => false,
                );
                break;
              default:
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => ScreenPage.route(),
      localizationsDelegates: [
        ms.intl.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: languages.map((lang) => Locale(lang, '')),
      locale: Locale(ms.intl.locale.languageCode),
      debugShowCheckedModeBanner: false,
    );
  }
}
