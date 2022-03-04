import 'package:flutter/material.dart';
import 'package:howdy/core/utilities/utilities.dart';
import 'package:howdy/route_generator.dart';

void main() async {
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
      initialRoute: isLoggedIn ? "/" : "/auth",
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
