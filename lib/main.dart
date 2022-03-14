import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:howdy/core/utilities/utilities.dart';
import 'package:howdy/route_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // var snapeshot = FirebaseFirestore.instance.collection("Users").snapshots();
  // print(snapeshot);
  bool isLoggedIn = false;
  isLoggedIn = await isUserLoggedIn();
  runApp(MyApp(
    isLoggedIn: isLoggedIn,
  ));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Howdy: Encrypted messaging app',
      theme: ThemeData.dark(),
      initialRoute: isLoggedIn ? "/home" : "/auth",
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
