part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final Email email;
  final Password password;
  final FormzStatus status;
  final ErrorModel? errMSG;

  const RegisterState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.errMSG,
  });

  @override
  List<Object> get props => [email, password, status];

  RegisterState copyWith({
    Email? email,
    Password? password,
    FormzStatus? status,
    ErrorModel? err,
  }) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errMSG: err ?? errMSG,
    );
  }
}
