import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:formz/formz.dart';
import 'package:ms/core/models/email.dart';
import 'package:ms/core/models/password.dart';
import 'package:ms/core/service/authentication_repository.dart';

part 'forgot_state.dart';
part 'forgot_event.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const ForgotPasswordState()) {
    on<ForgotEmailChanged>(
      (event, emit) {
        final email = Email.dirty(event.email);
        emit(
          state.copyWith(
            email: email,
            status: Formz.validate([email]),
          ),
        );
      },
    );

    on<ForgotSendResetPassword>(
      (event, emit) async {
        if (state.status.isValidated) {
          emit(state.copyWith(status: FormzStatus.submissionInProgress));
          try {
            await _authenticationRepository.sendPasswordResetEmail(
                email: state.email.value);
            emit(state.copyWith(status: FormzStatus.submissionSuccess));
          } on FirebaseAuthException catch (error) {
            emit(
              state.copyWith(
                error: error.code,
                status: FormzStatus.submissionFailure,
              ),
            );
          }
        }
      },
    );
  }

  final AuthenticationRepository _authenticationRepository;
}
