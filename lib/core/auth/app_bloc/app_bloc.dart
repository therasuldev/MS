import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';
part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AppState.unknown()) {
    on<AuthStatusChange>((event, emit) async {
      print("_onAuthenticationStatusChange: ${event.status}");
      switch (event.status) {
        case AppStatus.unauthenticated:
          return emit(const AppState.unauthenticated());
        case AppStatus.authenticated:
          final user = await _tryGetUser();
          print("tryGetUser - user: ${user?.id}");
          return user != null
              ? emit(AppState.authenticated(user))
              : emit(const AppState.unauthenticated());
        default:
          return emit(const AppState.unknown());
      }
    });
    on<AuthLogoutRequested>((event, emit) {
      _authenticationRepository.logOut();
    });
    _authenticationStatusSubscription =
        authenticationRepository.status.listen((status) {
      add(AuthStatusChange(status));
    });
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  late StreamSubscription<AppStatus> _authenticationStatusSubscription;

  Future<User?> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }
}
