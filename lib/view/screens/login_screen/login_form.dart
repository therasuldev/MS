import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ms/core/auth/app_bloc/app_bloc.dart';
import 'package:ms/core/auth/login_bloc/login_bloc.dart';

import 'package:ms/view/widgets/utils.dart';
import '../../../mystore.dart';
import '../../ui/animation_button.dart';
import '../../widgets/widget.dart';
import '../forgot_password_screen.dart';

class LoginForm extends MSStatefulWidget {
  LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends MSState<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  LoginBloc? _loginBloc;
  AppBloc? _authBloc;

  // void _onEmailChange() {
  //   _loginBloc?.add(LoginEmailChange(email: _emailController.text));
  // }

  // void _onPasswordChange() {
  //   _loginBloc?.add(LoginPasswordChanged(password: _passwordController.text));
  // }

  @override
  void initState() {
    super.initState();
    // _emailController.addListener(_onEmailChange);
    // _passwordController.addListener(_onPasswordChange);
    //_loginBloc = BlocProvider.of<LoginBloc>(context);
   // _authBloc = BlocProvider.of<AppBloc>(context);
  }

  @override
  void dispose() {
    //_emailController.dispose();
    // _passwordController.dispose();
    _authBloc!.close();
    _loginBloc!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) async {
            if (state.status.isSubmissionFailure) {
              ViewUtils.showSnack(
                context,
                color: snackErrorColor,
                title: ms.fmt(context, 'error.${state.errMSG!.code}'),
              );
            } else if (state.status.isSubmissionSuccess) {
              _authBloc?.add(AuthLogoutRequested());
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
        ),
      ),
    );
  }
}

class KLoginForm extends MSStatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  KLoginForm({
    Key? key,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  @override
  State<KLoginForm> createState() => _KLoginFormState();
}

class _KLoginFormState extends MSState<KLoginForm> {
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
            buildWhen: (previous, current) => previous.status != current.status,
            builder: (context, state) => TextFormField(
              onChanged: (email) =>
                  context.read<LoginBloc>().add(LoginEmailChange(email)),
              textInputAction: TextInputAction.next,
              // controller: widget.emailController,
              decoration: ViewUtils.nonBorderDecoration(
                hint: ms.fmt(context, 'account.email'),
              ),
              style: TextStyle(color: blackAccent),
              keyboardType: TextInputType.emailAddress,
            ),
          ),
        ),
        Container(
          width: size(context).width * .9,
          height: 50,
          padding: const EdgeInsets.only(left: 7),
          margin: const EdgeInsets.only(top: 10),
          decoration: ViewUtils.formDecoration(),
          child: BlocBuilder<LoginBloc, LoginState>(
            buildWhen: (previous, current) => previous.status != current.status,
            builder: (context, state) => TextFormField(
              onChanged: (password) =>
                  context.read<LoginBloc>().add(LoginPasswordChange(password)),
              //controller: widget.passwordController,
              decoration: ViewUtils.nonBorderDecoration(
                  hint: ms.fmt(context, 'account.password')),
              style: TextStyle(color: blackAccent),
              keyboardType: TextInputType.text,
              obscureText: true,
            ),
          ),
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
            builder: (context, state) {
              if (state.status == FormzStatus.submissionInProgress) {
                return SpinKitCircle(color: spinkitColor);
              } else {
                return Text(
                  ms.fmt(context, 'auth.signIn'),
                  style: TextStyle(color: spinkitColor, fontSize: 18),
                );
              }
            },
          ),
          titleColor: spinkitColor,
          width: size(context).width * .9,
        )
      ],
    );
  }
}
