part of 'app_bloc.dart';

class AppState extends Equatable {
  const AppState._({
    this.status = AppStatus.unknown,
    this.user = User.empty,
  });

  const AppState.unknown() : this._();

  const AppState.authenticated(User user) : this._(
    status: AppStatus.unauthenticated,
    user: user
  );

  const AppState.unauthenticated() : this._(
    status: AppStatus.unauthenticated
  );

  final AppStatus status;
  final User? user;

  @override
  List<Object> get props => [status, user!];
}