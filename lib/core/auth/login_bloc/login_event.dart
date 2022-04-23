part of 'login_bloc.dart';


abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginEmailChange extends LoginEvent {
  const LoginEmailChange(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class LoginPasswordChange extends LoginEvent {
  const LoginPasswordChange(this.password);

  final String password;

  @override
  List<Object?> get props => [password];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}
