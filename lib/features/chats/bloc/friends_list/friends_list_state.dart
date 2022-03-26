part of 'friends_list_bloc.dart';

abstract class FriendsListState {
  const FriendsListState();
}

class FriendsListLoading extends FriendsListState {}

class FriendsListLoaded extends FriendsListState {
  final List<FriendListItemModel> friendsList;

  const FriendsListLoaded(this.friendsList);
}
