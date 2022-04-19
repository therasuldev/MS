import 'package:bloc/bloc.dart';
import 'package:ms/core/auth/signup_bloc/signup_event.dart';
import 'package:ms/core/auth/signup_bloc/signup_state.dart';
import 'package:ms/core/models/error.dart';
import 'package:ms/core/service/user_service.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserService _userService;

  RegisterBloc({required UserService userService})
      : _userService = userService,
        super(RegisterState.initial());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    // if (event is RegisterEmailChanged) {
    //   yield* _mapRegisterEmailChangeToState(event.email);
    // } else if (event is RegisterPasswordChanged) {
    //   yield* _mapRegisterPasswordChangeToState(event.password);
    // }
    if (event is RegisterSubmitted) {
      yield* _mapRegisterSubmittedToState(
          email: event.email, password: event.password);
    }
  }

  // Stream<RegisterState> _mapRegisterEmailChangeToState(String email) async* {
  //   yield state.update(isEmailValid: Validators.isValidEmail(email));
  // }

  // Stream<RegisterState> _mapRegisterPasswordChangeToState(
  //     String password) async* {
  //   yield state.update(isPasswordValid: Validators.isValidPassword(password));
  // }

  Stream<RegisterState> _mapRegisterSubmittedToState(
      {required String email, required String password}) async* {
    yield RegisterState.loading();
    try {
      await _userService.signUp(email: email, password: password);
      yield RegisterState.success();
    } catch (err) {
      yield RegisterState.failure(error: ErrorModel.fromException(err)!);
    }
  }
}
