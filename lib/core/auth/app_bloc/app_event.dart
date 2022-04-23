part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {

  @override
  List<Object?> get props => [];
}

class AuthStatusChange extends AppEvent {
   AuthStatusChange(this.status);

  final AppStatus status;

  @override
  List<Object?> get props => [status];
}

class AuthLogoutRequested extends AppEvent {}