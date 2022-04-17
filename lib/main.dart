import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'core/app/intl.dart';
import 'core/app/ms.dart';
import 'core/repositories/user_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final MS ms = MS();
  ms.intl = Intl();
  ms.intl.locale = const Locale('az');
  ms.intl.supportedLocales = languages;

  final userRepository = UserRepository();
  runApp(MyApp(userRepository: userRepository));
}
