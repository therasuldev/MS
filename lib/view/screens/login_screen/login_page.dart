import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ms/core/auth/login/login_bloc.dart';
import 'package:ms/core/service/authentication_repository.dart';
import 'package:ms/view/screens/login_screen/login_form.dart';
import 'package:ms/view/widgets/widget.dart';

class LoginPage extends MSStatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  final authenticationRepository = AuthenticationRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider<LoginBloc>(
          create: (context) {
            return LoginBloc(
              authenticationRepository: authenticationRepository,
            );
          },
          child: LoginForm(),
        ),
      ),
    );
  }
}
