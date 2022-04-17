import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ms/core/auth/app_bloc/app_bloc.dart';
import 'package:ms/core/auth/app_bloc/app_event.dart';
import 'package:ms/core/auth/signup_bloc/signup_bloc.dart';
import 'package:ms/core/auth/signup_bloc/signup_event.dart';
import 'package:ms/core/auth/signup_bloc/signup_state.dart';
import '../../../mystore.dart';
import '../../ui/animation_button.dart';
import '../../widgets/widget.dart';

class SignUpForm extends MSStatefulWidget {
  SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends MSState<SignUpForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  RegisterBloc? _registerBloc;

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(_onEmailChange);
    _passwordController.addListener(_onPasswordChange);
  }

  void _onEmailChange() {
    _registerBloc!.add(RegisterEmailChanged(email: _emailController.text));
  }

  void _onPasswordChange() {
    _registerBloc!
        .add(RegisterPasswordChanged(password: _passwordController.text));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state.isFailure!) {
              fsnack(
                context: context,
                title: ms.fmt(context, 'snackbar.title-error'),
                error: ms.fmt(context, 'error.${state.error!.code}'),
                snackcolor: snackErrorColor,
                position: FlushbarPosition.BOTTOM,
              );
            }
            if (state.isSubmitting!) {
              SpinKitCircle(color: spinkitColor);
            }
            if (state.isSuccess!) {
              BlocProvider.of<AuthBloc>(context).add(AuthLoggedIn());
            }
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                _signUpTitle(context),
                const SizedBox(height: 20),
                KRegisterForm(
                  emailController: _emailController,
                  passwordController: _passwordController,
                ),
                const SizedBox(height: 40),
                RichText(
                  text: TextSpan(
                    text: ms.fmt(context, 'note'),
                    style: TextStyle(color: blackAccent),
                    children: [
                      _notes(ms.fmt(context, 'note.1')),
                      _notes(ms.fmt(context, 'note.2')),
                      _notes(ms.fmt(context, 'note.3'))
                    ],
                  ),
                  softWrap: true,
                  textScaleFactor: 1.1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextSpan _notes(String _text) {
    return TextSpan(
        text: ms.fmt(context, _text),
        style: TextStyle(height: 2, color: blackAccent));
  }

  Widget _signUpTitle(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: size(context).width * .05),
          child: Text(
            ms.fmt(context, 'auth.signUp'),
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: darkBlueColor, fontSize: 33),
          ),
        ),
        Expanded(child: Container()),
      ],
    );
  }
}

class KRegisterForm extends MSStatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  KRegisterForm({
    Key? key,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  @override
  State<KRegisterForm> createState() => _KRegisterFormState();
}

class _KRegisterFormState extends MSState<KRegisterForm> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Column(
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
                  hintText: ms.fmt(context, 'account.email'),
                  hintStyle: TextStyle(color: greyAccent),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                ),
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
                ),
                style: TextStyle(color: blackAccent),
                keyboardType: TextInputType.text,
              ),
            ),
            const SizedBox(height: 30),
            AnimePressButton(
              borderRadius: BorderRadius.circular(100),
              onTap: () async {
                BlocProvider.of<RegisterBloc>(context).add(
                  RegisterSubmitted(
                      email: widget.emailController.text.trim(),
                      password: widget.passwordController.text.trim()),
                );
              },
              title: BlocBuilder<RegisterBloc, RegisterState>(
                builder: (context, state) {
                  if (state.isSubmitting!) {
                    return SpinKitCircle(color: spinkitColor);
                  } else {
                    return Text(
                      ms.fmt(context, 'auth.signUp'),
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
      },
    );
  }
}
