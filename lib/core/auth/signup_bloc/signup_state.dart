import 'package:ms/core/models/error.dart';

class RegisterState {
  final bool? isSubmitting;
  final bool? isSuccess;
  final bool? isFailure;
  final ErrorModel? error;

  RegisterState(
      {this.error, this.isSubmitting, this.isSuccess, this.isFailure});

  factory RegisterState.initial() {
    return RegisterState(
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.loading() {
    return RegisterState(
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.failure({required ErrorModel error}) {
    return RegisterState(
      error: error,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory RegisterState.success() {
    return RegisterState(
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  RegisterState update() {
    return copyWith(
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  RegisterState copyWith({
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return RegisterState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }
}
