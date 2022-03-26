import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:howdy/features/chats/bloc/blocs.dart';

class SearchUsersPage extends StatelessWidget {
  const SearchUsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        elevation: 0,
        // title: const Text("Search"),
        title: Padding(
          padding: const EdgeInsets.all(0),
          child: TextField(
            onChanged: (value) async {
              if (value.isEmpty || value == " ") {
                BlocProvider.of<SearchBloc>(context)
                    .add(const SearchEmitIdleEvent());
              } else {
                BlocProvider.of<SearchBloc>(context)
                    .add(SearchUserEvent(value));
              }
            },
            onSubmitted: (value) {
              if (value.isEmpty || value == " ") {
                BlocProvider.of<SearchBloc>(context)
                    .add(const SearchEmitIdleEvent());
              } else {
                BlocProvider.of<SearchBloc>(context)
                    .add(SearchUserEvent(value));
              }
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
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is SearchLoaded) {
            if (state.users.isEmpty) {
              return const Center(
                child: Text(
                  "We couldn't find what you are searching for.",
                  style: TextStyle(fontSize: 16),
                ),
              );
            }
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                var user = state.users[index];
                // return Text(state.users[index].displayName);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () {
                      //TODO: got to chat room page
                    },
                    leading: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(100)),
                      child: SizedBox(
                        width: 60,
                        height: 60,
                        child: Image(
                          image: NetworkImage(user.photoURL),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(user.displayName),
                    subtitle: Text(user.username),
                  ),
                );
              },
            );
          }
          return const Center(
            child: Text(
              "Start typing to find friends.",
              style: TextStyle(fontSize: 16),
            ),
          );
        },
      ),
    );
  }
}
