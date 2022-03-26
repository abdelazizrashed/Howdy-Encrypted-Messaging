import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:howdy/features/chats/models/models.dart';
import 'package:howdy/features/chats/services/services.dart';

part 'friends_list_event.dart';
part 'friends_list_state.dart';

class FriendsListBloc extends Bloc<FriendsListEvent, FriendsListState> {
  FriendListServices friendListServices = FriendListServices();
  FriendsListBloc() : super(FriendsListLoading()) {
    on<GetFriendsListEvent>(_onGetFriendsListEvent);
  }

  FutureOr<void> _onGetFriendsListEvent(
      GetFriendsListEvent event, Emitter<FriendsListState> emit) async {
    emit(FriendsListLoading());
    var friendsList = await friendListServices.getFriendListSnapshots();

    await emit.forEach<DocumentSnapshot<Map<String, dynamic>>>(
      friendsList,
      onData: (DocumentSnapshot<Map<String, dynamic>> data) {
        List<FriendListItemModel> friendsList = [];
        for (var entry
            in (data.data()?["friendsList"] as Map<String, dynamic>).entries) {
          var value = entry.value as Map<String, dynamic>;
          value["uid"] = entry.key;
          var friendListItem = FriendListItemModel.fromJson(value);
          friendsList.add(friendListItem);
        }
        return FriendsListLoaded(friendsList);
      },
    );
  }
}
