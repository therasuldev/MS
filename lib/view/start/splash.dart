import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ms/core/repositories/user_repository.dart';

import 'package:ms/view/screens/login_screen/login_page.dart';
import 'package:ms/view/screens/signup_screen/signup_page.dart';

import '../../mystore.dart';
import '../ui/animation_button.dart';
import '../widgets/widget.dart';

class ScreenPage extends MSStatefulWidget {
  ScreenPage({Key? key}) : super(key: key);

  @override
  _ScreenPageState createState() => _ScreenPageState();
}

class _ScreenPageState extends MSState<ScreenPage> {
  final userRepository = UserRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlueColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            UIdecor(
              child: Lottie.asset(
                onb1,
                width: size(context).width * .75,
                height: size(context).height * .75,
              ),
              alignment: const Alignment(-.9, 0),
            ),
            const SizedBox(height: 10),
            Text(
              'Onlayn paltar magazasi',
              style: TextStyle(color: spinkitColor, fontSize: 25),
            ),
            const SizedBox(height: 10),
            Text(
              screenSubtitle,
              style: TextStyle(color: spinkitColor, fontSize: 15),
            ),
            const SizedBox(height: 20),
            AnimePressButton(
              borderRadius: BorderRadius.circular(100),
              onTap: () => pageRoute(
                context: context,
                route: LoginPage(userRepository:userRepository),
                back: true,
              ),
              title: Text(
                ms.fmt(context, 'auth.signIn'),
                style: TextStyle(color: spinkitColor, fontSize: 22),
              ),
              titleColor: spinkitColor,
              width: size(context).width * .9,
            ),
            const SizedBox(height: 20),
            AnimePressButton(
              borderRadius: BorderRadius.circular(100),
              onTap: () => pageRoute(
                context: context,
                route: SignUpPage(userRepository:userRepository),
                back: true,
              ),
              title: Text(
                ms.fmt(context, 'auth.signUp'),
                style: TextStyle(color: spinkitColor, fontSize: 22),
              ),
              titleColor: spinkitColor,
              width: size(context).width * .9,
            ),
          ],
        ),
      ),
    );
  }
}
