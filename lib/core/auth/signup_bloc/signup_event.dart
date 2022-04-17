import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterEmailChanged extends RegisterEvent {
  final String email;

  RegisterEmailChanged({required this.email});

  @override
  List<Object> get props => [email];
}

class RegisterPasswordChanged extends RegisterEvent {
  final String password;

  RegisterPasswordChanged({required this.password});

  @override
  List<Object> get props => [password];
}

class RegisterSubmitted extends RegisterEvent {
  final String email;
  final String password;

  RegisterSubmitted({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}