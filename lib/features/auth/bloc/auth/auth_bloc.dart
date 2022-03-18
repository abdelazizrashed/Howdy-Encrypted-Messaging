import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:howdy/features/auth/services/auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late AuthServices _auth;
  AuthBloc() : super(AuthLoading()) {
    _auth = AuthServices();
    on<RegisterWithEmailAndPassword>(_onRegisterWithEmailAndPassword);
    on<LoginWithEmailAndPassword>(_onLoginWithEmailAndPassword);
    on<LoginWithGoogle>(_onLoginWithGoogle);
    on<LogOut>(_onLogOut);
  }

  Future<FutureOr<void>> _onRegisterWithEmailAndPassword(
      RegisterWithEmailAndPassword event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    var userCreds = await _auth.registerWithEmail(event.avatar, event.username,
        event.displayName, event.email, event.password, event.context);
    emit(
      LoggedIn(
        userCredential: userCreds,
      ),
    );
  }

  Future<FutureOr<void>> _onLoginWithEmailAndPassword(
      LoginWithEmailAndPassword event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    var userCreds = await _auth.loginWithEmail(event.email, event.password);
    emit(
      LoggedIn(
        userCredential: userCreds,
      ),
    );
  }

  Future<FutureOr<void>> _onLoginWithGoogle(
      LoginWithGoogle event, Emitter<AuthState> emit) async {
    emit(AuthIdle());
    var userCreds = await _auth.signinWithGoogle();
    emit(
      LoggedIn(
        userCredential: userCreds,
      ),
    );
  }

  Future<FutureOr<void>> _onLogOut(
      LogOut event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await _auth.logout();
    emit(
      const LoggedOut(),
    );
  }
}
