import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ms/core/auth/app_bloc/app_bloc.dart';
import 'package:ms/core/auth/app_bloc/app_event.dart';
import 'package:ms/core/auth/app_bloc/app_state.dart';
import 'package:ms/core/auth/login_bloc/login_bloc.dart';
import 'package:ms/core/auth/signup_bloc/signup_bloc.dart';
import 'package:ms/core/service/user_service.dart';
import 'package:ms/view/home/home.dart';
import 'package:ms/view/start/splash.dart';

import 'core/app/intl.dart';
import 'mystore.dart';
import 'view/widgets/widget.dart';

class MyApp extends MSStatelessWidget {
  MyApp({Key? key, required UserService userService})
      : _userService = userService,
        super(key: key);

  final UserService _userService;
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState? get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              AuthBloc(userService: _userService)..add(AuthStarted()),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          floatingActionButtonTheme:
              FloatingActionButtonThemeData(backgroundColor: kBackgroundColor),
          appBarTheme: AppBarTheme(backgroundColor: kBackgroundColor),
        ),
        navigatorKey: _navigatorKey,
        builder: (context, child) => BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              _navigator!.pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => ScreenPage()),
                  (route) => false);
            } else if (state is AuthSuccess) {
              _navigator!.pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => HomePage(user: state.user)),
                  (route) => false);
            }
          },
          child: child,
        ),
        onGenerateRoute: (_) => MaterialPageRoute(builder: (_) => ScreenPage()),
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
    );
  }
}
