import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ms/core/models/email.dart';
import 'package:ms/core/models/user.dart';
import 'package:ms/core/models/user_model.dart';

part 'user_state.dart';
part 'user_event.dart';

// class UserCubit extends Cubit<UserState> {
//   UserCubit() : super( UserState());
//   final firebaseFirestore = FirebaseFirestore.instance;
//   Future setName({String? userName}) async {
// try {
//   final collection = firebaseFirestore.collection(userName!).doc('uuid');
//   UserModel user = UserModel();
//   final newUser = user.copyWith(userName: userName);
//   await collection.set(newUser.toJson());
// } catch (e) {
//   log('Adınızı qeyd etmədiniz');
// }
//   }
// }
class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserState()) {
    on<UserNameChanged>(_onNameChanged);
    on<UserNameSubmitted>(_onNameSubmitted);
  }

  _onNameChanged(UserNameChanged event, Emitter<UserState> emit) {
    final username = Email.dirty(event.username);
    emit(
        state.copyWith(userName: username, status: Formz.validate([username])));
  }

  _onNameSubmitted(UserNameSubmitted event, Emitter<UserState> emit) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        final collection = firebaseFirestore
            .collection(state.userName.value)
            .doc(state.userName.value.hashCode.toString());
        UserModel user = UserModel();
        final newUser = user.copyWith(userName: state.userName.value);
        await collection.set(newUser.toJson());
      } catch (e) {
        log('Adınızı qeyd etmədiniz');
      }
    }
  }

  final firebaseFirestore = FirebaseFirestore.instance;
}
