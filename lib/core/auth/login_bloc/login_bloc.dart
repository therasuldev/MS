import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ms/core/auth/login_bloc/login_event.dart';
import 'package:ms/core/auth/login_bloc/login_state.dart';
import 'package:ms/core/models/error.dart';
import 'package:ms/core/repositories/user_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;

  LoginBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(LoginState.initial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    // if (event is LoginEmailChange) {
    //   yield* _mapLoginEmailChangeToState(event.email);
    // } else if (event is LoginPasswordChanged) {
    //   yield* _mapLoginPasswordChangeToState(event.password);
    // }
    if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
          email: event.email, password: event.password);
    }
  }

  // Stream<LoginState> _mapLoginEmailChangeToState(String email) async* {
  //   yield state.update(isEmailValid: Validators.isValidEmail(email));
  // }

  // Stream<LoginState> _mapLoginPasswordChangeToState(String password) async* {
  //   yield state.update(isPasswordValid: Validators.isValidPassword(password));
  // }

  Stream<LoginState> _mapLoginWithCredentialsPressedToState(
      {required String email, required String password}) async* {
    yield LoginState.loading();
    try {
      await _userRepository.signInWithCredentials(email, password);
      yield LoginState.success();
    } on FirebaseAuthException catch (err) {
      yield LoginState.failure(error: ErrorModel.fromException(err)!);
    }
  }
}
