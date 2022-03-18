import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:howdy/features/auth/models/models.dart';
import 'package:howdy/features/auth/services/services.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  late UserServices _user;
  UserBloc() : super(UserIdle()) {
    _user = UserServices();
    on<SaveUserInDatabaseEvent>(_onSaveUserInDatabaseEvent);
    on<GetUserFromDatabaseEvent>(_onGetUserFromDatabaseEvent);
    on<SetUserLoggedInEvent>(_onSetUserLoggedInEvent);
  }

  Future<FutureOr<void>> _onSaveUserInDatabaseEvent(
      SaveUserInDatabaseEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    await _user.saveUserInDatabase(event.user);
    emit(const SetUserLoaded());
  }

  Future<FutureOr<void>> _onGetUserFromDatabaseEvent(
      GetUserFromDatabaseEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    var user = await _user.getUserFromDatabase(event.uid);
    emit(GetUserLoaded(user));
  }

  Future<FutureOr<void>> _onSetUserLoggedInEvent(
      SetUserLoggedInEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    await _user.setUserLoggedIn(event.user);
    emit(const SetUserLoaded());
  }
}
