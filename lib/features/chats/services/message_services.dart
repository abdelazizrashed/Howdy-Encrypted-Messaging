import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:howdy/features/auth/services/services.dart';
import 'package:howdy/features/chats/models/message_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageServices {
  Future<void> sendMessage(MessageModel message) async {
    //Save the message in from user data
    await FirebaseFirestore.instance
        .collection("Messages")
        .doc(message.fromUid)
        .collection(message.toUid)
        .doc((message.createdAt.millisecondsSinceEpoch / 1000)
            .round()
            .toString())
        .set(message.toJson());
    //Save the message in to user data
    await FirebaseFirestore.instance
        .collection("Messages")
        .doc(message.toUid)
        .collection(message.fromUid)
        .doc((message.createdAt.millisecondsSinceEpoch / 1000)
            .round()
            .toString())
        .set(message.toJsonReverse());
    var _userServices = UserServices();
    var fromUser = await _userServices.getUserFromDatabase(message.fromUid);
    var toUser = await _userServices.getUserFromDatabase(message.toUid);
    //update the last message
    await FirebaseFirestore.instance
        .collection("FriendsList")
        .doc(message.fromUid)
        .set(
      {
        "friendsList": {
          message.toUid: {
            "createdAt":
                (message.createdAt.millisecondsSinceEpoch / 1000).round(),
            "displayName": toUser.displayName,
            "photoURL": toUser.photoURL,
            "lastMessage":
                message.text == null || (message.text?.isEmpty ?? true)
                    ? "attachment"
                    : message.text,
          },
        }
      },
    );
    //update the last message
    await FirebaseFirestore.instance
        .collection("FriendsList")
        .doc(message.toUid)
        .set(
      {
        "friendsList": {
          message.fromUid: {
            "createdAt":
                (message.createdAt.millisecondsSinceEpoch / 1000).round(),
            "displayName": fromUser.displayName,
            "photoURL": fromUser.photoURL,
            "lastMessage":
                message.text == null || (message.text?.isEmpty ?? true)
                    ? "attachment"
                    : message.text,
          },
        }
      },
    );
  }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getMessagesStream(
      String friendUid) async {
    var uid = (await SharedPreferences.getInstance()).getString("uid");
    return FirebaseFirestore.instance
        .collection("Messages")
        .doc(uid)
        .collection(friendUid)
        .snapshots();
  }
}
