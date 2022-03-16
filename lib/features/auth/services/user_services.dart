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

  static void saveUserInDatabase(UserModel user) {
    var ref = FirebaseFirestore.instance.collection("Users").doc(user.uid);
    var json = UserServices.toJson(user);
    ref.set(json);
  }

  static Map<String, Object> toJson(UserModel user) {
    return {
      "displayName": user.displayName,
      "email": user.email,
      "photoURL": user.photoURL,
      "uid": user.uid,
      "username": user.username,
    };
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
