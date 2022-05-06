part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class UserNameChanged extends UserEvent {
  final String username;

  const UserNameChanged(this.username);

  @override
  List<Object> get props => [username];
}

class UserNameSubmitted extends UserEvent {
  const UserNameSubmitted();
}
