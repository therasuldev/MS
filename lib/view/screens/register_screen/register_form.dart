import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ms/core/auth/register/register_bloc.dart';
import 'package:ms/view/widgets/utils.dart';
import '../../../mystore.dart';
import '../../ui/animation_button.dart';
import '../../widgets/widget.dart';
import 'package:formz/formz.dart';

class RegisterForm extends MSStatefulWidget {
  RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends MSState<RegisterForm> {
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
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) async {
            if (state.status.isSubmissionFailure) {
              ViewUtils.showSnack(
                context,
                title: ms.fmt(context, 'error.${state.error}'),
                color: snackErrorColor,
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
            buildWhen: (previous, current) => previous.email != current.email,
            builder: (context, state) {
              return TextFormField(
                key: const Key('registerForm_usernameInput_textField'),
                textInputAction: TextInputAction.next,
                controller: widget.emailController,
                decoration: ViewUtils.nonBorderDecoration(
                  hint: ms.fmt(context, 'account.email'),
                ),
                onChanged: (email) => context
                    .read<RegisterBloc>()
                    .add(RegisterEmailChanged(email)),
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
                  previous.password != current.password,
              builder: (context, state) {
                return TextFormField(
                  key: const Key('registerForm_passwordInput_textField'),
                  controller: widget.passwordController,
                  decoration: ViewUtils.nonBorderDecoration(
                    hint: ms.fmt(context, 'account.password'),
                  ),
                  onChanged: (password) => context
                      .read<RegisterBloc>()
                      .add(RegisterPasswordChanged(password)),
                  style: TextStyle(color: blackAccent),
                  keyboardType: TextInputType.text,
                );
              }),
        ),
        const SizedBox(height: 30),
        AnimePressButton(
          borderRadius: BorderRadius.circular(100),
          onTap: () async {
            context.read<RegisterBloc>().add(const RegisterSubmitted());
          },
          title: BlocBuilder<RegisterBloc, RegisterState>(
              builder: (context, state) {
            final registerStyle = TextStyle(color: spinkitColor, fontSize: 18);
            return state.status.isSubmissionInProgress
                ? SpinKitCircle(color: spinkitColor)
                : Text(ms.fmt(context, 'auth.signUp'), style: registerStyle);
          }),
          titleColor: spinkitColor,
          width: size(context).width * .9,
        )
      ],
    );
  }
}
