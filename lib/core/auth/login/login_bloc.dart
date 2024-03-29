import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:formz/formz.dart';
import 'package:ms/core/models/email.dart';
import 'package:ms/core/models/password.dart';
import 'package:ms/core/service/authentication_repository.dart';

part 'login_state.dart';
part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const LoginState()) {
    on<LoginEmailChanged>(
      (event, emit) {
        final email = Email.dirty(event.email);
        emit(
          state.copyWith(
            email: email,
            status: Formz.validate([state.password, email]),
          ),
        );
      },
    );
    on<LoginPasswordChanged>(
      (event, emit) {
        final password = Password.dirty(event.password);
        emit(state.copyWith(
          password: password,
          status: Formz.validate([password, state.email]),
        ));
      },
    );
    on<LoginSubmitted>(
      (event, emit) async {
        if (state.status.isValidated) {
          emit(state.copyWith(status: FormzStatus.submissionInProgress));
          try {
            await _authenticationRepository.signInWithCredentials(
              email: state.email.value,
              password: state.password.value,
            );
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
