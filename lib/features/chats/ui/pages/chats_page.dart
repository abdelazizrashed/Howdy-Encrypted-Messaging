part of "home_page.dart";

class ChatsPage extends StatelessWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FriendsListBloc>(context).add(const GetFriendsListEvent());
    return BlocBuilder<FriendsListBloc, FriendsListState>(
      builder: (context, state) {
        if (state is FriendsListLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is FriendsListLoaded) {
          var friendsList = state.friendsList;
          if (friendsList.isEmpty) {
            return const Center(
              child: Text(
                "Search for friends and start messaging now",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8),
            child: ListView.builder(
              itemCount: friendsList.length,
              itemBuilder: (context, index) {
                return MessageCard(friendListItem: friendsList[index]);
              },
            ),
          );
        }
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Search for friends and start messaging now",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        );
      },
    );
  }
}
