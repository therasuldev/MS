import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ms/core/auth/login_bloc/login_bloc.dart';
import '../ui/animation_button.dart';
import '../widgets/widget.dart';

import '../../mystore.dart';

class ForgotPasswordPage extends MSStatefulWidget {
  ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends MSState<ForgotPasswordPage> {
  final email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.status==FormzStatus.submissionFailure) {
              fsnack(
                context: context,
                title: ms.fmt(context, 'snackbar.title-error'),
                error: ms.fmt(context, 'error.{state.error!.code}'),
                snackcolor: snackErrorColor,
                position: FlushbarPosition.BOTTOM,
              );
            }
            if (state.status==FormzStatus.submissionSuccess) {
              fsnack(
                context: context,
                title: ms.fmt(context, 'snackbar.title-success'),
                error: ms.fmt(context, 'snackbar.text-success'),
                snackcolor: snackSuccessColor,
                position: FlushbarPosition.BOTTOM,
              );
            }
          },
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: size(context).width * .05),
                      child: Text(
                        ms.fmt(context, 'auth.sendPasswordResetMail'),
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: darkBlueColor),
                      ),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
                const SizedBox(height: 20),
                // Field(child: _emailFormField(context)),
                SizedBox(height: size(context).height * .08),
                _sendEmailButton(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sendEmailButton(BuildContext context) {
    return AnimePressButton(
      borderRadius: BorderRadius.circular(100),
      onTap: () async {
        //context.read<LoginCubit>().resetPass(email.text.trim());
      },
      title: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state.status==FormzStatus.submissionInProgress) {
            return SpinKitCircle(color: spinkitColor);
          } else {
            return Text(
              ms.fmt(context, 'auth.send'),
              style: TextStyle(color: spinkitColor, fontSize: 18),
            );
          }
        },
      ),
      titleColor: spinkitColor,
      width: size(context).width * .5,
    );
  }

  Widget _emailFormField(BuildContext context) {
    return TextFormField(
      controller: email,
      decoration: InputDecoration(
        hintText: ms.fmt(context, 'account.email'),
        hintStyle: TextStyle(color: greyAccent),
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
      ),
      style: TextStyle(color: blackAccent),
      keyboardType: TextInputType.emailAddress,
    );
  }
}
