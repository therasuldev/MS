import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ms/core/auth/app_bloc/app_bloc.dart';
import 'package:ms/core/auth/app_bloc/app_event.dart';
import 'package:ms/core/auth/login_bloc/login_bloc.dart';
import 'package:ms/core/auth/login_bloc/login_state.dart';
import 'package:ms/core/service/user_service.dart';
import 'package:ms/view/widgets/widget.dart';

class Person extends MSStatefulWidget {
  Person({this.userService, Key? key}) : super(key: key);
  final UserService? userService;

  @override
  State<Person> createState() => _PersonState();
}

class _PersonState extends MSState<Person> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => LoginBloc(userService: widget.userService!),
      child: Center(
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) async {},
          child: TextButton(
              child: const Text('Exit'), onPressed: () => UserService()),
        ),
      ),
    ));
  }
}
