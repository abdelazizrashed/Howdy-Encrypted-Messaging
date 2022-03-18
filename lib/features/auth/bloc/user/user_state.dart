part of 'user_bloc.dart';

@immutable
abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {}

class UserIdle extends UserState {}

class GetUserLoaded extends UserState {
  final UserModel user;
  const GetUserLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class SetUserLoaded extends UserState {
  const SetUserLoaded();

  @override
  List<Object> get props => [];
}

