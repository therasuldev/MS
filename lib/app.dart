import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ms/core/auth/app_bloc/app_bloc.dart';
import 'package:ms/core/auth/login_bloc/login_bloc.dart';
import 'package:ms/view/home/home.dart';
import 'package:ms/view/start/splash.dart';
import 'package:user_repository/user_repository.dart';

import 'core/app/intl.dart';
import 'mystore.dart';
import 'view/widgets/widget.dart';

class MyApp extends MSStatelessWidget {
  MyApp({
    Key? key,
    required this.userRepository,
    required this.authenticationRepository,
  }) : super(key: key);

  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AppBloc(
                userRepository: userRepository,
                authenticationRepository: authenticationRepository),
          ),
          BlocProvider(
              create: (context) =>
                  LoginBloc(authenticationRepository: authenticationRepository))
          // BlocProvider(
          //     create: (context) => RegisterBloc(userService: _userService))
        ],
        child: MaterialApp(
          theme: ThemeData(
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: kBackgroundColor),
            appBarTheme: AppBarTheme(backgroundColor: kBackgroundColor),
          ),
          navigatorKey: _navigatorKey,
          builder: (context, child) => BlocListener<AppBloc, AppState>(
            listener: (context, state) {
              // if (state.status) {
              //   _navigator!.pushAndRemoveUntil(
              //       MaterialPageRoute(builder: (context) => ScreenPage()),
              //       (route) => false);
              // } else if (state is AuthSuccess) {
              //   _navigator!.pushAndRemoveUntil(
              //       MaterialPageRoute(
              //           builder: (context) => HomePage(user: state.user)),
              //       (route) => false);
              // }
              switch (state.status) {
                case AppStatus.authenticated:
                  _navigator.pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (_) => HomePage(user: state.user)),
                      (route) => false);
                  break;
                case AppStatus.unauthenticated:
                  _navigator.pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => ScreenPage()),
                      (route) => false);
                  break;
                default:
                  break;
              }
            },
            child: child,
          ),
          onGenerateRoute: (_) =>
              MaterialPageRoute(builder: (_) => ScreenPage()),
          localizationsDelegates: [
            ms.intl.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: languages.map((lang) => Locale(lang, '')),
          locale: Locale(ms.intl.locale.languageCode),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
