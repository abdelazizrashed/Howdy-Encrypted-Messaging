import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:howdy/features/auth/models/models.dart';

class UserSearchServices {
  Future<List<UserModel>> searchUsers(String searchTerm) async {
    var usersByUsername = await FirebaseFirestore.instance
        .collection("Users")
        .where("username", isGreaterThanOrEqualTo: searchTerm)
        .get();
    List<UserModel> users = [];
    for (var user in usersByUsername.docs) {
      users.add(UserModel.fromJson(user.data()));
    }
    return users;
  }
}
