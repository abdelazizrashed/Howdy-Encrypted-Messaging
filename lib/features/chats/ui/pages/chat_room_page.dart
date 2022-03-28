import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:howdy/features/chats/bloc/blocs.dart';
import 'package:howdy/features/chats/ui/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/models.dart';

// ignore: must_be_immutable
class ChatRoomPage extends StatelessWidget {
  final FriendListItemModel friendListItem;
  ChatRoomPage({Key? key, required this.friendListItem}) : super(key: key);

  TextEditingController msgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MessageBloc>(context)
        .add(GetMessagesEvent(friendListItem.uid));
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
                child: BlocBuilder<MessageBloc, MessageState>(
                  builder: (context, state) {
                    if (state is MessageLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is MessageLoaded) {
                      if (state.messages.isEmpty) {
                        return Center(
                          child: Text(
                              "Start typing to send your first message to ${friendListItem.displayName}."),
                        );
                      }
                      return ListView.builder(
                        reverse: true,
                        itemCount: state.messages.length,
                        itemBuilder: (context, index) {
                          var msg = state.messages[index];
                          if (msg.messageDirection ==
                              MessageDirection.recieved) {
                            if (msg.text != null) {
                              return RecievedMessage(message: msg.text!);
                            }
                          }
                          if (msg.text != null) {
                            return SentMessage(message: msg.text!);
                          }
                          return Container(); //TODO: check for other types of messages and display them.
                        },
                      );
                    }

                    return Center(
                      child: Text(
                          "Start typing to send your first message to ${friendListItem.displayName}."),
                    );
                  },
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    controller: msgController,
                    decoration: const InputDecoration(
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
                  onPressed: () async {
                    var uid = (await SharedPreferences.getInstance())
                        .getString("uid");
                    if (msgController.text.isNotEmpty &&
                        msgController.text.trim().isNotEmpty) {
                      var msg = MessageModel(
                        createdAt: DateTime.now(),
                        messageDirection: MessageDirection.sent,
                        messageType: MessageType.text,
                        fromUid: uid!,
                        toUid: friendListItem.uid,
                        text: msgController.text,
                      );
                      BlocProvider.of<MessageBloc>(context)
                          .add(SendMessagesEvent(msg));
                      msgController.clear();
                    }
                  },
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
