import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'core/utilities/user_login_status.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  bool isLoggedIn = false;
  isLoggedIn = await isUserLoggedIn();
  runApp(App(
    isLoggedIn: isLoggedIn,
  ));
}
