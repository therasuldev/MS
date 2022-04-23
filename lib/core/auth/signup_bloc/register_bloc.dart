import 'dart:developer';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:formz/formz.dart';
import 'package:ms/core/models/email.dart';
import 'package:ms/core/models/error.dart';
import 'package:ms/core/models/password.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthenticationRepository authenticationRepository;

  RegisterBloc(this.authenticationRepository) : super(const RegisterState()) {
    on<RegisterEmailChanged>((event, emit) {
      final email = Email.dirty(event.email);
      emit(
        state.copyWith(
          email: email,
          status: Formz.validate([email, state.password]),
        ),
      );
    });
    on<RegisterPasswordChanged>((event, emit) {
      final password = Password.dirty(event.password);
      emit(
        state.copyWith(
          password: password,
          status: Formz.validate([state.email, password]),
        ),
      );
    });
    on<RegisterSubmitted>((event, emit) {
      if (state.status.isValidated) {
        log("_onSubmitted status ${state.status}");
        emit(state.copyWith(status: FormzStatus.submissionInProgress));
        try {
          // authenticationRepository.(
          //     email: state.email.value, password: state.password.value);
          emit(state.copyWith(status: FormzStatus.submissionSuccess));
        } on FirebaseAuthException catch (err) {
          emit(
            state.copyWith(
              err: ErrorModel.fromException(err),
              status: FormzStatus.submissionFailure,
            ),
          );
        }
      }
    });
  }
}
