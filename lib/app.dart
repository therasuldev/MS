import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ms/core/auth/app_bloc/app_bloc.dart';
import 'package:ms/core/auth/app_bloc/app_event.dart';
import 'package:ms/core/auth/app_bloc/app_state.dart';
import 'package:ms/core/auth/login_bloc/login_bloc.dart';
import 'package:ms/view/home/home.dart';
import 'package:ms/view/start/splash.dart';

import 'core/app/intl.dart';
import 'core/repositories/user_repository.dart';
import 'mystore.dart';
import 'view/widgets/widget.dart';

class MyApp extends MSStatelessWidget {
  MyApp({Key? key, required UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  final UserRepository _userRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              AuthBloc(userRepository: _userRepository)..add(AuthStarted()),
        ),
        BlocProvider(
            create: (context) => LoginBloc(userRepository: _userRepository))
      ],
      child: MaterialApp(
        theme: ThemeData(
          floatingActionButtonTheme:
              FloatingActionButtonThemeData(backgroundColor: kBackgroundColor),
          appBarTheme: AppBarTheme(backgroundColor: kBackgroundColor),
        ),
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthFailure) {
              return ScreenPage();
            } else if (state is AuthSuccess) {
              return HomePage(user: state.user);
            }
            return SpinKitCircle(color: spinkitColor);
          },
        ),
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
