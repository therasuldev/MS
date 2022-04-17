import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ms/core/auth/login_bloc/login_bloc.dart';
import 'package:ms/core/repositories/user_repository.dart';
import 'package:ms/view/screens/login_screen/login_form.dart';
import 'package:ms/view/widgets/widget.dart';

class LoginPage extends MSStatelessWidget {
  LoginPage({required this.userRepository, Key? key}) : super(key: key);
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => LoginBloc(userRepository: userRepository),
        child: LoginForm(),
      ),
    );
  }
}
