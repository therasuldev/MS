import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ms/core/auth/register/register_bloc.dart';
import 'package:ms/core/service/authentication_repository.dart';
import 'package:ms/view/screens/register_screen/register_form.dart';
import 'package:ms/view/widgets/widget.dart';

class RegisterPage extends MSStatelessWidget {
   RegisterPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) =>  RegisterPage());
  }

  final authenticationRepository = AuthenticationRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider<RegisterBloc>(
          create: (context) {
            return RegisterBloc(
              authenticationRepository: authenticationRepository,
            );
          },
          child: RegisterForm(),
        ),
      ),
    );
  }
}
