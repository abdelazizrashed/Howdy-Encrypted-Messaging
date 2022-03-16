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

  static void saveUserInDatabase(UserModel user) {
    var ref = FirebaseFirestore.instance.collection("Users").doc(user.uid);
    var json = UserServices.toJson(user);
    ref.set(json);
  }

  static Future<UserModel> getUserFromDatabase(String uid) async {
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

  static void setUserLoggedIn(UserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", user.email);

    prefs.setString("name", user.displayName);

    prefs.setString("phoneNumber", user.username);

    prefs.setString("photoUrl", user.photoURL);

    prefs.setString("uid", user.uid);
    prefs.setBool("isLoggedIn", true);
  }
}
