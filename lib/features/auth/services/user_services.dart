import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:howdy/features/auth/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserServices {
  static Future<bool> checkIfUserExists(String username) async {
    var user = await FirebaseFirestore.instance
        .collection("Users")
        .doc(username)
        .get();
    return user.exists;
  }

  static void saveUserInDatabase(UserModel user) {
    var ref = FirebaseFirestore.instance.collection("Users").doc(user.username);
    var json = UserServices.toJson(user);
    ref.set(json);
    // setUserLoggedIn(user); //Todo uncomment this
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

    prefs.setString("userId", user.uid);
    prefs.setBool("isLoggedIn", true);
  }
}
