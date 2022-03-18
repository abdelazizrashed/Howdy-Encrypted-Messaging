part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class RegisterWithEmailAndPassword extends AuthEvent {
  final PlatformFile? avatar;
  final String username;
  final String displayName;
  final String email;
  final String password;
  final BuildContext context;

  const RegisterWithEmailAndPassword({
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

class LoginWithEmailAndPassword extends AuthEvent {
  final String email;
  final String password;
  const LoginWithEmailAndPassword({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [
        email,
        password,
      ];
}

class LoginWithGoogle extends AuthEvent {
  const LoginWithGoogle();

  @override
  List<Object> get props => [];
}

class LogOut extends AuthEvent {
  const LogOut();

  @override
  List<Object> get props => [];
}
