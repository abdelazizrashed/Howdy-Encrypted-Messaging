import 'package:shared_preferences/shared_preferences.dart';

Future<bool> isUserLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var isLoggedIn = prefs.getBool("isLoggedIn");
  if (isLoggedIn == null) {
    return false;
  }
  return isLoggedIn;
}


