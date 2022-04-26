import 'package:flutter/material.dart';
import 'package:ms/view/widgets/widget.dart';

class SplashScreen extends MSStatelessWidget {
  SplashScreen({Key? key}) : super(key: key);
   static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SplashScreen());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Image(image: AssetImage('assets/img/splash.png'))),
    );
  }
}
