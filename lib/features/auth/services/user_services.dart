import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:howdy/features/auth/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserServices {
  static Future<bool> checkIfUsernameExists(String username) async {
    var users = await FirebaseFirestore.instance
        .collection("Users")
        .where("username", isEqualTo: username)
        .get();
    if (users.size > 0) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> checkIfUserExists(String uid) async {
    var snapshot =
        await FirebaseFirestore.instance.collection("Users").doc(uid).get();
    return snapshot.exists;
  }

  Future<void> saveUserInDatabase(UserModel user) async {
    var ref = FirebaseFirestore.instance.collection("Users").doc(user.uid);
    var json = UserServices.toJson(user);
    await ref.set(json);
    await setUserLoggedIn(user);
  }

  Future<UserModel> getUserFromDatabase(String uid) async {
    var snapshot =
        await FirebaseFirestore.instance.collection("Users").doc(uid).get();
    var json = snapshot.data() ?? {"": null};
    return UserServices.fromJson(json);
  }

  static Map<String, dynamic> toJson(UserModel user) {
    return {
      "displayName": user.displayName,
      "email": user.email,
      "photoURL": user.photoURL,
      "uid": user.uid,
      "username": user.username,
    };
  }

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json["email"] as String,
      displayName: json["displayName"] as String,
      photoURL: json["photoURL"] as String,
      uid: json["uid"] as String,
      username: json["username"] as String,
    );
  }

  Future<void> setUserLoggedIn(UserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("email", user.email);

    await prefs.setString("name", user.displayName);

    await prefs.setString("phoneNumber", user.username);

    await prefs.setString("photoUrl", user.photoURL);

    await prefs.setString("uid", user.uid);
    await prefs.setBool("isLoggedIn", true);
  }
}
