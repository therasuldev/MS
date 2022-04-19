import 'package:bloc/bloc.dart';
import 'package:ms/core/auth/app_bloc/app_event.dart';
import 'package:ms/core/auth/app_bloc/app_state.dart';
import 'package:ms/core/service/user_service.dart';


class AuthBloc
    extends Bloc<AuthEvent, AuthState> {
  final UserService _userService;

  AuthBloc({required UserService userService})
      : _userService = userService,
        super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
      AuthEvent event) async* {
    if (event is AuthStarted) {
      yield* _mapAuthenticationStartedToState();
    } else if (event is AuthLoggedIn) {
      yield* _mapAuthenticationLoggedInToState();
    } else if (event is AuthLoggedOut) {
      yield* _mapAuthenticationLoggedOutInToState();
    }
  }

  //AuthenticationLoggedOut
  Stream<AuthState> _mapAuthenticationLoggedOutInToState() async* {
    yield AuthFailure();
    _userService.signOut();
  }

  //AuthenticationLoggedIn
  Stream<AuthState> _mapAuthenticationLoggedInToState() async* {
    yield AuthSuccess(await _userService.getUser());
  }

  // AuthenticationStarted
  Stream<AuthState> _mapAuthenticationStartedToState() async* {
    final isSignedIn = await _userService.isSignedIn();
    if (isSignedIn) {
      final user = await _userService.getUser();
      yield AuthSuccess(user);
    } else {
      yield AuthFailure();
    }
  }
}