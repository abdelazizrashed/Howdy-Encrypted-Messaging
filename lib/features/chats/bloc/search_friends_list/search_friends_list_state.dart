part of 'search_friends_list_bloc.dart';

abstract class SearchFriendsListState {
  const SearchFriendsListState();
}

class SearchFriendsListLoading extends SearchFriendsListState {}

class SearchFriendsListIdle extends SearchFriendsListState {}

class SearchFriendsListLoaded extends SearchFriendsListState {
  final List<FriendListItemModel> friendsList;

  const SearchFriendsListLoaded(this.friendsList);
}
