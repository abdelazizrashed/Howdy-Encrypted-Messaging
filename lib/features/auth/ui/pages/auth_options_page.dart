import 'package:cloud_firestore/cloud_firestore.dart';
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

  StreamBuilder<QuerySnapshot<Object?>> newMethod(
      CollectionReference<Object?> usersCollection) {
    return StreamBuilder(
      stream: usersCollection.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        var users = snapshot.data?.docs;
        if (users == null) {
          return const Center(
            child: Text("No Users were found"),
          );
        }
        return Center(
          child: ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: ((BuildContext context, int index) {
              return Center(
                child: Text(
                  users[index]["name"],
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
