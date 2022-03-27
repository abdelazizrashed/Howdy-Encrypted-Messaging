import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:howdy/features/chats/models/friend_list_item_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FriendListServices {
  Future<Stream<DocumentSnapshot<Map<String, dynamic>>>>
      getFriendListSnapshots() async {
    var uid = (await SharedPreferences.getInstance()).getString("uid");
    return FirebaseFirestore.instance
        .collection("FriendsList")
        .doc(uid)
        .snapshots();
  }

  Future<List<FriendListItemModel>> searchFriendsList(String query) async {
    var uid = (await SharedPreferences.getInstance()).getString("uid");
    var friendsListSnapshot = await FirebaseFirestore.instance
        .collection("FriendsList")
        .doc(uid)
        .get();

    var friendsListJson =
        friendsListSnapshot.data()?["friendsList"] as Map<String, dynamic>;
    List<FriendListItemModel> friendsList = [];
    for (var entry in friendsListJson.entries) {
      var value = entry.value;
      value["uid"] = entry.key;
      friendsList.add(FriendListItemModel.fromJson(value));
    }
    return friendsList.where((element) {
      return element.displayName.toLowerCase().contains(query.toLowerCase()) ||
          query.toLowerCase().contains(element.displayName.toLowerCase());
    }).toList();
  }
}
