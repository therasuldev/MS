import 'dart:async';

class AuthenticationRepository {
  final _controller = StreamController<AppStatus>();

  Stream<AppStatus> get status async* {
    await Future.delayed(const Duration(seconds: 1));
    yield AppStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    print("AuthenticationRepository - logIn username: $email password: $password");
    Future.delayed(const Duration(milliseconds: 300), () {
      _controller.add(AppStatus.authenticated);
    });
  }

  void logOut() {
    _controller.add(AppStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}

enum AppStatus { unknown, authenticated, unauthenticated }

