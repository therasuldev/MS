import 'package:ms/core/models/error.dart';

class LoginState {
 
  final bool? isSubmitting;
  final bool? isSuccess;
  final bool? isFailure;
  final ErrorModel? error;


  LoginState(
      {required this.error,

      this.isSubmitting,
      this.isSuccess,
      this.isFailure});

  factory LoginState.initial() {
    return LoginState(
     
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      error: null,
    );
  }

  factory LoginState.loading() {
    return LoginState(
 
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
      error: null,
    );
  }

  factory LoginState.failure({required ErrorModel error}) {
    return LoginState(
      error: error,
    
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory LoginState.success() {
    return LoginState(
      error: null,
 
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  LoginState update() {
    return copyWith(
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  LoginState copyWith({
    ErrorModel? error,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return LoginState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      error: error ?? this.error,
    );
  }
}
