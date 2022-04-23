import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ms/bloc_observer.dart';
import 'package:user_repository/user_repository.dart';
import 'app.dart';
import 'core/app/intl.dart';
import 'core/app/ms.dart';

Future<void> main() async {
  return BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();

      final MS ms = MS();
      ms.intl = Intl();
      ms.intl.locale = const Locale('az');
      ms.intl.supportedLocales = languages;

      runApp(
        MyApp(
          authenticationRepository: AuthenticationRepository(),
          userRepository: UserRepository(),
        ),
      );
    },
    blocObserver: AppBlocObserver(),
  );
}
