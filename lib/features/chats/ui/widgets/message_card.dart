import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:howdy/features/chats/models/message_status.dart';
import 'package:howdy/features/chats/models/models.dart';
import 'package:intl/intl.dart';

class MessageCard extends StatelessWidget {
  final FriendListItemModel friendListItem;

  const MessageCard({
    Key? key,
    required this.friendListItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String time;
    var today =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    var yesterday = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day - 1);
    var tempDate = DateTime(friendListItem.createdAt.year,
        friendListItem.createdAt.month, friendListItem.createdAt.day);
    if (tempDate == today) {
      time = DateFormat('hh:mm a').format(friendListItem.createdAt);
    } else if (tempDate == yesterday) {
      time = "Yesterday";
    } else {
      time = DateFormat("M-d").format(friendListItem.createdAt);
      if (friendListItem.createdAt.year < today.year &&
          friendListItem.createdAt.year > 2000) {
        var temp = friendListItem.createdAt.year - 2000;
        time = temp.toString() + "-" + time;
      }
    }
    return ListTile(
      onTap: () {
        //TODO: go to chat room
      },
      leading: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        child: SizedBox(
          width: 60,
          height: 60,
          child: Image(
            image: NetworkImage(friendListItem.photoURL),
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        friendListItem.displayName,
      ),
      subtitle: Text(
        friendListItem.lastMessage,
        maxLines: 2,
      ),
      trailing: Text(time),
    );
  }
}
