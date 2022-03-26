import 'package:cloud_firestore/cloud_firestore.dart';
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
}
