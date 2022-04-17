import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ms/core/auth/signup_bloc/signup_bloc.dart';
import 'package:ms/view/screens/signup_screen/signup_form.dart';
import 'package:ms/view/widgets/widget.dart';

import '../../../core/repositories/user_repository.dart';

class SignUpPage extends MSStatelessWidget {
  SignUpPage({required this.userRepository, Key? key}) : super(key: key);

  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => RegisterBloc(userRepository: userRepository),
        child: SignUpForm(),
      ),
    );
  }
}
