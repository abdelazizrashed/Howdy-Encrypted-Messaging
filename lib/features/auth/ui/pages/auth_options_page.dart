import 'package:flutter/material.dart';


class AuthOptionsPage extends StatelessWidget {
  const AuthOptionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Image(
              image: AssetImage(
                "assets/imgs/voice-calls.png",
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushNamed("/signup-options");
            },
            child: const Padding(
              padding: EdgeInsets.only(
                bottom: 20,
                top: 20,
                right: 40,
                left: 40,
              ),
              child: Text(
                "Get Started",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
            ),
            onPressed: () async {
              Navigator.of(context).pushNamed("/login-options");
            },
            child: const Padding(
              padding: EdgeInsets.only(
                bottom: 10,
                top: 10,
                right: 20,
                left: 20,
              ),
              child: Text(
                "Log In",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
