import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:howdy/features/chats/models/friend_list_item_model.dart';
import 'package:howdy/features/chats/services/friend_list_services.dart';

part 'search_friends_list_event.dart';
part 'search_friends_list_state.dart';

class SearchFriendsListBloc
    extends Bloc<SearchFriendsListEvent, SearchFriendsListState> {
  final FriendListServices friendListServices = FriendListServices();
  SearchFriendsListBloc() : super(SearchFriendsListIdle()) {
    on<SearchFriendsListForFriendEvent>(_onSearchFriendsListForFriendEvent);
  }

  Future<FutureOr<void>> _onSearchFriendsListForFriendEvent(
      SearchFriendsListForFriendEvent event,
      Emitter<SearchFriendsListState> emit) async {
    emit(SearchFriendsListLoading());
    var friendsList =
        await friendListServices.searchFriendsList(event.searchQuery);
    emit(SearchFriendsListLoaded(friendsList));
  }
}
