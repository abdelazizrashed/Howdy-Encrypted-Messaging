import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:howdy/features/chats/ui/widgets/message_card.dart';

import '../../bloc/blocs.dart';

class SearchFriendsListPage extends StatelessWidget {
  const SearchFriendsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.all(0),
          child: TextField(
            onChanged: (value) async {
              BlocProvider.of<SearchFriendsListBloc>(context)
                  .add(SearchFriendsListForFriendEvent(value));
            },
            onSubmitted: (value) {
              BlocProvider.of<SearchFriendsListBloc>(context)
                  .add(SearchFriendsListForFriendEvent(value));
            },
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: "Search",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(100.0)),
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(100.0)),
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<SearchFriendsListBloc, SearchFriendsListState>(
        builder: (context, state) {
          if (state is SearchFriendsListLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is SearchFriendsListLoaded) {
            if (state.friendsList.isEmpty) {
              return const Center(
                child: Text(
                  "We couldn't find what you are searching for.",
                  style: TextStyle(fontSize: 16),
                ),
              );
            }
            return ListView.builder(
              itemCount: state.friendsList.length,
              itemBuilder: (context, index) {
                var friendsListItem = state.friendsList[index];
                // return Text(state.users[index].displayName);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MessageCard(
                    friendListItem: friendsListItem,
                  ),
                );
              },
            );
          }
          return const Center(
            child: Text(
              "Start typing to find conversations.",
              style: TextStyle(fontSize: 16),
            ),
          );
        },
      ),
    );
  }
}
