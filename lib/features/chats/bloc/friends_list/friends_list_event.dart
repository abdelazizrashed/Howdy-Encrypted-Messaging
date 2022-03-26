part of 'friends_list_bloc.dart';

abstract class FriendsListEvent extends Equatable {
  const FriendsListEvent();

  @override
  List<Object> get props => [];
}

class GetFriendsListEvent extends FriendsListEvent {
  const GetFriendsListEvent();

  @override
  List<Object> get props => [];
}
