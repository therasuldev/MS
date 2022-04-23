import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ms/core/auth/app_bloc/app_bloc.dart';
import 'package:ms/core/auth/signup_bloc/register_bloc.dart';
import 'package:ms/view/widgets/utils.dart';
import '../../../mystore.dart';
import '../../ui/animation_button.dart';
import '../../widgets/widget.dart';
import 'package:formz/formz.dart';

class SignUpForm extends MSStatefulWidget {
  SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends MSState<SignUpForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  RegisterBloc? _registerBloc;
  AppBloc? _authBloc;

  // void _onEmailChange() {
  //   _registerBloc!.add(RegisterEmailChanged(email: _emailController.text));
  // }

  // void _onPasswordChange() {
  //   _registerBloc!
  //       .add(RegisterPasswordChanged(password: _passwordController.text));
  // }

  @override
  void initState() {
    super.initState();
    // _emailController.addListener(_onEmailChange);
    // _passwordController.addListener(_onPasswordChange);
    _authBloc = BlocProvider.of<AppBloc>(context);
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
  }

  @override
  void dispose() {
    // _emailController.dispose();
    // _passwordController.dispose();
    _authBloc!.close();
    _registerBloc!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) async {
            if (state.status.isSubmissionFailure) {
              ViewUtils.showSnack(
                context,
                title: ms.fmt(context, 'error.${state.errMSG!.code}'),
                color: snackErrorColor,
              );
            }
            if (state.status.isSubmissionSuccess) {
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
                        ms.fmt(context, 'auth.signUp'),
                        style: TextStyle(color: darkBlueColor, fontSize: 33),
                      ),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
                const SizedBox(height: 20),
                KRegisterForm(
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
    return Column(
      children: [
        Container(
          width: size(context).width * .9,
          height: 50,
          padding: const EdgeInsets.only(left: 7),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: ViewUtils.formDecoration(),
          child: BlocBuilder<RegisterBloc, RegisterState>(
            buildWhen: (previous, current) => previous.status != current.status,
            builder: (context, state) {
              return TextFormField(
                onChanged: (email) => context
                    .read<RegisterBloc>()
                    .add(RegisterEmailChanged(email: email)),
                textInputAction: TextInputAction.next,
                controller: widget.emailController,
                decoration: ViewUtils.nonBorderDecoration(
                  hint: ms.fmt(context, 'account.email'),
                ),
                style: TextStyle(color: blackAccent),
                keyboardType: TextInputType.emailAddress,
              );
            },
          ),
        ),
        Container(
          width: size(context).width * .9,
          height: 50,
          padding: const EdgeInsets.only(left: 7),
          margin: const EdgeInsets.only(top: 10),
          decoration: ViewUtils.formDecoration(),
          child: BlocBuilder<RegisterBloc, RegisterState>(
              buildWhen: (previous, current) =>
                  previous.status != current.status,
              builder: (context, state) {
                return TextFormField(
                  onChanged: (password) => context
                      .read<RegisterBloc>()
                      .add(RegisterPasswordChanged(password: password)),
                  controller: widget.passwordController,
                  decoration: ViewUtils.nonBorderDecoration(
                    hint: ms.fmt(context, 'account.password'),
                  ),
                  style: TextStyle(color: blackAccent),
                  keyboardType: TextInputType.text,
                );
              }),
        ),
        const SizedBox(height: 30),
        AnimePressButton(
          borderRadius: BorderRadius.circular(100),
          onTap: () async {
            context.read<RegisterBloc>().add(
                  RegisterSubmitted(
                    email: widget.emailController.text.trim(),
                    password: widget.passwordController.text.trim(),
                  ),
                );
          },
          title: BlocBuilder<RegisterBloc, RegisterState>(
            builder: (context, state) {
              if (state.status.isSubmissionInProgress) {
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
  }
}
