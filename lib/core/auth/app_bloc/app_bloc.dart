import 'package:bloc/bloc.dart';
import 'package:ms/core/auth/app_bloc/app_event.dart';
import 'package:ms/core/auth/app_bloc/app_state.dart';
import 'package:ms/core/repositories/user_repository.dart';


class AuthBloc
    extends Bloc<AuthEvent, AuthState> {
  final UserRepository _userRepository;

  AuthBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
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
    _userRepository.signOut();
  }

  //AuthenticationLoggedIn
  Stream<AuthState> _mapAuthenticationLoggedInToState() async* {
    yield AuthSuccess(await _userRepository.getUser());
  }

  // AuthenticationStarted
  Stream<AuthState> _mapAuthenticationStartedToState() async* {
    final isSignedIn = await _userRepository.isSignedIn();
    if (isSignedIn) {
      final user = await _userRepository.getUser();
      yield AuthSuccess(user);
    } else {
      yield AuthFailure();
    }
  }
}