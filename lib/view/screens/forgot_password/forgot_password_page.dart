import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ms/core/auth/forgot_password/forgot_bloc.dart';
import 'package:ms/core/service/authentication_repository.dart';
import 'package:ms/view/screens/forgot_password/forgot_password_screen.dart';
import 'package:ms/view/widgets/widget.dart';

class ForgotPasswordPage extends MSStatelessWidget {
  ForgotPasswordPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ForgotPasswordPage());
  }

  final authenticationRepository = AuthenticationRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider<ForgotPasswordBloc>(
          create: (context) {
            return ForgotPasswordBloc(
              authenticationRepository: authenticationRepository,
            );
          },
          child: ForgotPasswordForm(),
        ),
      ),
    );
  }
}
