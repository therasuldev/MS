import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ms/core/auth/app_bloc/app_bloc.dart';
import 'package:ms/core/auth/app_bloc/app_event.dart';
import 'package:ms/core/auth/login_bloc/login_bloc.dart';
import 'package:ms/core/auth/login_bloc/login_event.dart';
import 'package:ms/core/auth/login_bloc/login_state.dart';
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
  AuthBloc? _authBloc;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _loginBloc?.close();
    super.dispose();
  }

  void _onEmailChange() {
    _loginBloc?.add(LoginEmailChange(email: _emailController.text));
  }

  void _onPasswordChange() {
    _loginBloc?.add(LoginPasswordChanged(password: _passwordController.text));
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _emailController.addListener(_onEmailChange);
    _passwordController.addListener(_onPasswordChange);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) async {
            if (state.isFailure!) {
              fsnack(
                context: context,
                title: ms.fmt(context, 'snackbar.title-error'),
                error: ms.fmt(context, 'error.${state.error!.code}'),
                snackcolor: snackErrorColor,
                position: FlushbarPosition.BOTTOM,
              );
            }

            if (state.isSuccess!) {
              _authBloc?.add(AuthLoggedIn());
              Navigator.pop(context);
            }
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),
                _LoginTitle(),
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

class _LoginTitle extends MSStatelessWidget {
  _LoginTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: size(context).width * .05),
          child: Text(
            ms.fmt(context, 'auth.signIn'),
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: darkBlueColor),
          ),
        ),
        Expanded(child: Container())
      ],
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
  bool isSecure = true;

  void onTap() => setState(() => isSecure = !isSecure);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) => Column(
        children: [
          Container(
            width: size(context).width * .9,
            height: 50,
            padding: const EdgeInsets.only(left: 7),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 222, 237, 245),
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              controller: widget.emailController,
              decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  suffixIcon: GestureDetector(
                      onTap: () {
                        fsnack(
                          context: context,
                          error: ms.fmt(context, 'snackbar.text-info'),
                          title: ms.fmt(context, 'snackbar.title-note'),
                          snackcolor: darkBlueColor,
                          position: FlushbarPosition.TOP,
                        );
                      },
                      child: Icon(Icons.info, color: greyAccent)),
                  hintText: ms.fmt(context, 'account.email'),
                  hintStyle: TextStyle(color: greyAccent)),
              style: TextStyle(color: blackAccent),
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          Container(
            width: size(context).width * .9,
            height: 50,
            padding: const EdgeInsets.only(left: 7),
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 222, 237, 245),
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextFormField(
              controller: widget.passwordController,
              decoration: InputDecoration(
                hintText: ms.fmt(context, 'account.password'),
                hintStyle: TextStyle(color: greyAccent),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                suffixIcon: IconButton(
                    onPressed: onTap,
                    icon: isSecure
                        ? Icon(Icons.visibility_off, color: greyAccent)
                        : Icon(Icons.visibility, color: greyAccent)),
              ),
              style: TextStyle(color: blackAccent),
              keyboardType: TextInputType.text,
              obscureText: isSecure,
            ),
          ),
          Align(
            child: TextButton(
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
            heightFactor: 1,
            alignment: Alignment(size(context).width * .002, 0),
          ),
          const SizedBox(height: 30),
          AnimePressButton(
            borderRadius: BorderRadius.circular(100),
            onTap: () async {
              context.read<LoginBloc>().add(
                    LoginWithCredentialsPressed(
                        email: widget.emailController.text.trim(),
                        password: widget.passwordController.text.trim()),
                  );
            },
            title: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state.isSubmitting!) {
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
      ),
    );
  }
}
