import 'package:flutter/material.dart';
import 'package:howdy/features/chats/models/friend_list_item_model.dart';
import 'package:howdy/features/chats/ui/widgets/widgets.dart';

class ChatRoomPage extends StatelessWidget {
  final FriendListItemModel friendListItem;
  const ChatRoomPage({Key? key, required this.friendListItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
        ),
        elevation: 0,
        title: Text(friendListItem.displayName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ListView.builder(
                  reverse: true,
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    if (index % 2 == 0) {
                      return RecievedMessage(
                          message: friendListItem.lastMessage);
                    } else {
                      return SentMessage(
                          message: "Hi " + friendListItem.displayName);
                    }
                  },
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: "Type a message",
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
                IconButton(
                  iconSize: 30,
                  onPressed: () {},
                  icon: const Icon(
                    Icons.send,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
