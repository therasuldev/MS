import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ms/core/auth/login/login_bloc.dart';
import 'package:ms/view/screens/forgot_password_screen.dart';

import 'package:ms/view/widgets/utils.dart';
import '../../../mystore.dart';
import '../../ui/animation_button.dart';
import '../../widgets/widget.dart';

class LoginForm extends MSStatefulWidget {
  LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends MSState<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) async {
        if (state.status.isSubmissionFailure) {
          ViewUtils.showSnack(
            context,
            color: snackErrorColor,
            title: ms.fmt(context, 'error.${state.error}'),
          );
        }
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: size(context).width * .05),
                  child: Text(
                    ms.fmt(context, 'auth.signIn'),
                    style: TextStyle(color: darkBlueColor, fontSize: 45),
                  ),
                ),
                Expanded(child: Container())
              ],
            ),
            const SizedBox(height: 20),
            KLoginForm(
              emailController: _emailController,
              passwordController: _passwordController,
            ),
          ],
        ),
      ),
    );
  }
}

class KLoginForm extends MSStatelessWidget {
  KLoginForm({
    required this.emailController,
    required this.passwordController,
    Key? key,
  }) : super(key: key);
  final TextEditingController emailController;
  final TextEditingController passwordController;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: size(context).width * .9,
          height: 50,
          padding: const EdgeInsets.only(left: 7),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: ViewUtils.formDecoration(),
          child: BlocBuilder<LoginBloc, LoginState>(
              buildWhen: (previous, current) => previous.email != current.email,
              builder: (context, state) {
                return TextFormField(
                  key: const Key('loginForm_emailInput_textField'),
                  textInputAction: TextInputAction.next,
                  controller: emailController,
                  decoration: ViewUtils.nonBorderDecoration(
                    hint: ms.fmt(context, 'account.email'),
                  ),
                  onChanged: (email) =>
                      context.read<LoginBloc>().add(LoginEmailChanged(email)),
                  style: TextStyle(color: blackAccent),
                  keyboardType: TextInputType.emailAddress,
                );
              }),
        ),
        Container(
          width: size(context).width * .9,
          height: 50,
          padding: const EdgeInsets.only(left: 7),
          margin: const EdgeInsets.only(top: 10),
          decoration: ViewUtils.formDecoration(),
          child: BlocBuilder<LoginBloc, LoginState>(
              buildWhen: (previous, current) =>
                  previous.password != current.password,
              builder: (context, state) {
                return TextFormField(
                  key: const Key('loginForm_passwordInput_textField'),
                  controller: passwordController,
                  decoration: ViewUtils.nonBorderDecoration(
                      hint: ms.fmt(context, 'account.password')),
                  onChanged: (password) => context
                      .read<LoginBloc>()
                      .add(LoginPasswordChanged(password)),
                  style: TextStyle(color: blackAccent),
                  keyboardType: TextInputType.text,
                  obscureText: true,
                );
              }),
        ),
        TextButton(
          child: Text(
            ms.fmt(context, 'auth.forgotPassword'),
            style: TextStyle(color: darkBlueColor, fontSize: 15),
          ),
          onPressed: () => pageRoute(
            route: ForgotPasswordPage(),
            context: context,
            back: true,
          ),
        ),
        const SizedBox(height: 30),
        AnimePressButton(
          borderRadius: BorderRadius.circular(100),
          onTap: () async {
            context.read<LoginBloc>().add(const LoginSubmitted());
          },
          title: BlocBuilder<LoginBloc, LoginState>(
            buildWhen: (previous, current) => previous.status != current.status,
            builder: (context, state) {
              final loginStyle = TextStyle(color: spinkitColor, fontSize: 18);
              return state.status.isSubmissionInProgress
                  ? SpinKitCircle(color: spinkitColor)
                  : Text(ms.fmt(context, 'auth.signIn'), style: loginStyle);
            },
          ),
          titleColor: spinkitColor,
          width: size(context).width * .9,
        )
      ],
    );
  }
}
