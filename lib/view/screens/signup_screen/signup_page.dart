import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ms/core/auth/signup_bloc/signup_bloc.dart';
import 'package:ms/view/screens/signup_screen/signup_form.dart';
import 'package:ms/view/widgets/widget.dart';

import '../../../core/service/user_service.dart';

class SignUpPage extends MSStatelessWidget {
  SignUpPage({required this.userService, Key? key}) : super(key: key);

  final UserService userService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => RegisterBloc(userService: userService),
        child: SignUpForm(),
      ),
    );
  }
}
