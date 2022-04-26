import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ms/core/auth/forgot_password/forgot_bloc.dart';
import 'package:ms/view/widgets/utils.dart';
import '../../ui/animation_button.dart';
import '../../widgets/widget.dart';

import '../../../mystore.dart';

class ForgotPasswordForm extends MSStatefulWidget {
  ForgotPasswordForm({Key? key}) : super(key: key);

  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends MSState<ForgotPasswordForm> {
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) async {
        if (state.status.isSubmissionFailure) {
          ViewUtils.showSnack(
            context,
            color: snackErrorColor,
            msg: ms.fmt(context, 'error.${state.error}'),
          );
        }
        if (state.status.isSubmissionSuccess) {
          await ViewUtils.showSnack(
            context,
            color: snackSuccessColor,
            msg: ms.fmt(context, 'snackbar.text-success'),
          );
        }
      },
      child: Column(
        children: [
          const SizedBox(height: 30),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: size(context).width * .025),
                child: Text(
                  ms.fmt(context, 'auth.sendPasswordResetMail'),
                  style: TextStyle(fontSize: 35, color: darkBlueColor),
                ),
              ),
              Expanded(child: Container()),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            width: size(context).width * .9,
            height: 50,
            padding: const EdgeInsets.only(left: 7),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: ViewUtils.formDecoration(),
            child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                buildWhen: (previous, current) =>
                    previous.email != current.email,
                builder: (context, state) {
                  return TextFormField(
                    controller: _emailController,
                    key: const Key('forgotPasswordForm_emailInput_textField'),
                    textInputAction: TextInputAction.done,
                    decoration: ViewUtils.nonBorderDecoration(
                      hint: ms.fmt(context, 'account.email'),
                    ),
                    onChanged: (email) => context
                        .read<ForgotPasswordBloc>()
                        .add(ForgotEmailChanged(email)),
                    style: TextStyle(color: blackAccent),
                    keyboardType: TextInputType.emailAddress,
                  );
                }),
          ),
          const SizedBox(height: 30),
          _sendResetEmailButton(context)
        ],
      ),
    );
  }

  Widget _sendResetEmailButton(BuildContext context) {
    return AnimePressButton(
      borderRadius: BorderRadius.circular(100),
      onTap: () async {
        context.read<ForgotPasswordBloc>().add(const ForgotSendResetPassword());
      },
      title: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          final forgotStyle = TextStyle(color: spinkitColor, fontSize: 18);
          return state.status.isSubmissionInProgress
              ? SpinKitCircle(color: spinkitColor)
              : Text(ms.fmt(context, 'auth.send'), style: forgotStyle);
        },
      ),
      titleColor: spinkitColor,
      width: size(context).width * .5,
    );
  }
}
