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
  AuthBloc() : super(AuthIdle()) {
    _auth = AuthServices();
    on<RegisterWithEmailAndPasswordEvent>(_onRegisterWithEmailAndPassword);
    on<LoginWithEmailAndPasswordEvent>(_onLoginWithEmailAndPassword);
    on<LoginWithGoogleEvent>(_onLoginWithGoogle);
    on<LogOutEvent>(_onLogOut);
  }

  Future<FutureOr<void>> _onRegisterWithEmailAndPassword(
      RegisterWithEmailAndPasswordEvent event, Emitter<AuthState> emit) async {
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
      LoginWithEmailAndPasswordEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    var userCreds = await _auth.loginWithEmail(event.email, event.password);
    emit(
      LoggedIn(
        userCredential: userCreds,
      ),
    );
  }

  Future<FutureOr<void>> _onLoginWithGoogle(
      LoginWithGoogleEvent event, Emitter<AuthState> emit) async {
    emit(AuthIdle());
    var userCreds = await _auth.signinWithGoogle();
    emit(
      LoggedIn(
        userCredential: userCreds,
      ),
    );
  }

  Future<FutureOr<void>> _onLogOut(
      LogOutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await _auth.logout();
    emit(
      const LoggedOut(),
    );
  }
}
