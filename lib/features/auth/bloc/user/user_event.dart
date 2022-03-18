part of 'user_bloc.dart';

@immutable
abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class SaveUserInDatabaseEvent extends UserEvent {
  final UserModel user;
  const SaveUserInDatabaseEvent({
    required this.user,
  });

  @override
  List<Object?> get props => [user];
}

class GetUserFromDatabaseEvent extends UserEvent {
  final String uid;
  const GetUserFromDatabaseEvent(this.uid);

  @override
  List<Object?> get props => [uid];
}

class SetUserLoggedInEvent extends UserEvent {
  final UserModel user;
  const SetUserLoggedInEvent(this.user);

  @override
  List<Object?> get props => [user];
}
