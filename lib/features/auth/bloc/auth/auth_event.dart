part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class RegisterWithEmailAndPasswordEvent extends AuthEvent {
  final PlatformFile? avatar;
  final String username;
  final String displayName;
  final String email;
  final String password;
  final BuildContext context;

  const RegisterWithEmailAndPasswordEvent({
    this.avatar,
    required this.username,
    required this.displayName,
    required this.email,
    required this.password,
    required this.context,
  });

  @override
  List<Object?> get props => [
        avatar,
        username,
        displayName,
        email,
        password,
        context,
      ];
}

class LoginWithEmailAndPasswordEvent extends AuthEvent {
  final String email;
  final String password;
  const LoginWithEmailAndPasswordEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [
        email,
        password,
      ];
}

class LoginWithGoogleEvent extends AuthEvent {
  const LoginWithGoogleEvent();

  @override
  List<Object> get props => [];
}

class LogOutEvent extends AuthEvent {
  const LogOutEvent();

  @override
  List<Object> get props => [];
}
