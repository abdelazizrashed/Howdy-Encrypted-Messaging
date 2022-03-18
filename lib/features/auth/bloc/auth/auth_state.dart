part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {}
class AuthIdle extends AuthState {}

class LoggedIn extends AuthState {
  final UserCredential userCredential;

  const LoggedIn({required this.userCredential});
  @override
  List<Object> get props => [userCredential];
}

class LoggedOut extends AuthState {
  const LoggedOut();
  @override
  List<Object> get props => [];
}
