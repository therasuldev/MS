import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ms/core/service/user_service.dart';

import 'package:ms/view/screens/login_screen/login_form.dart';
import 'package:ms/view/screens/signup_screen/signup_form.dart';

import '../../mystore.dart';
import '../ui/animation_button.dart';
import '../widgets/widget.dart';

class ScreenPage extends MSStatefulWidget {
  ScreenPage({Key? key}) : super(key: key);
  static page() => MaterialPage(child: ScreenPage());

  @override
  _ScreenPageState createState() => _ScreenPageState();
}

class _ScreenPageState extends MSState<ScreenPage> {
 // final authenticationRepository = AuthenticationRepository();
  final style = TextStyle(color: spinkitColor, fontSize: 22);
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
                route: LoginForm(),
                back: true,
              ),
              title: Text(ms.fmt(context, 'auth.signIn'), style: style),
              titleColor: spinkitColor,
              width: size(context).width * .9,
            ),
            const SizedBox(height: 20),
            AnimePressButton(
              borderRadius: BorderRadius.circular(100),
              onTap: () => pageRoute(
                context: context,
                route: SignUpForm(),
                back: true,
              ),
              title: Text(ms.fmt(context, 'auth.signUp'), style: style),
              titleColor: spinkitColor,
              width: size(context).width * .9,
            ),
          ],
        ),
      ),
    );
  }
}
