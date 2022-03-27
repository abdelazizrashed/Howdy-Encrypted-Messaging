part of 'search_friends_list_bloc.dart';

abstract class SearchFriendsListEvent extends Equatable {
  const SearchFriendsListEvent();

  @override
  List<Object> get props => [];
}


class SearchFriendsListForFriendEvent extends SearchFriendsListEvent {
  final String searchQuery;
  const SearchFriendsListForFriendEvent(this.searchQuery);

  @override
  List<Object> get props => [searchQuery];
}