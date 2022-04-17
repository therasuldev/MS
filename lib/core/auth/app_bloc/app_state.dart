import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthSuccess extends AuthState {
  final User? user;

  const AuthSuccess(this.user);

  @override
  List<Object> get props => [user!];
}

class AuthFailure extends AuthState {}