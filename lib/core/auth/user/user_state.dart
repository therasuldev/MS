part of 'user_bloc.dart';

class UserState extends Equatable {
  final FormzStatus status;
  final Email userName;
  final String error;

  const UserState({
    this.status = FormzStatus.pure,
    this.userName = const Email.pure(),
    this.error = '',
  });

  UserState copyWith({
    FormzStatus? status,
    Email? userName,
    String? error,
  }) {
    return UserState(
      status: status ?? this.status,
      userName: userName ?? this.userName,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status , userName];
}
