import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../services/services.dart';

class LoginOptionsPage extends StatelessWidget {
  const LoginOptionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
        toolbarHeight: 70,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _renderSingupOptionBtn(
              "Login with google account",
              FontAwesomeIcons.google,
              () async {
                var userCredentials = await AuthServices.signinWithGoogle();
                bool isNewUser =
                    userCredentials.additionalUserInfo?.isNewUser ?? true;
                if (isNewUser) {
                  Navigator.of(context)
                      .pushNamed("/add-username", arguments: userCredentials);
                } else if (userCredentials.user != null) {
                  var userExists = await UserServices.checkIfUserExists(
                      userCredentials.user?.uid ?? "");
                  if (!userExists) {
                    Navigator.of(context)
                        .pushNamed("/add-username", arguments: userCredentials);
                  } else {
                    var user = await UserServices.getUserFromDatabase(
                        userCredentials.user?.uid ?? "");
                    UserServices.setUserLoggedIn(user);
                  }
                } else {
                  Fluttertoast.showToast(
                      msg: "Something went wrong. Try again.");
                }
              },
            ),
            _renderSingupOptionBtn(
              "Login with email",
              Icons.email_outlined,
              () {
                Navigator.of(context).pushNamed("/login-with-email");
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _renderSingupOptionBtn(
    String lbl,
    IconData icon,
    Function()? callback,
  ) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(350, 50),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
        ),
        onPressed: callback,
        label: Text(
          lbl,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        icon: Icon(icon),
      ),
    );
  }
}
