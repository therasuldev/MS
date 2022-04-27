import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ms/constant/constant.dart';
import 'package:ms/view/widgets/widget.dart';

class SplashScreen extends MSStatelessWidget {
  SplashScreen({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SplashScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: SpinKitCircle(color: blackAccent)),
    );
  }
}
