import 'package:flutter/material.dart';
import 'package:howdy/features/auth/services/auth.dart';
// import 'package:fluttericon/font_awesome_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignupOptionsPage extends StatelessWidget {
  const SignupOptionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign up"),
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
              "Register with google account",
              FontAwesomeIcons.google,
              () async {
                var userCredentials = await AuthServices.signinWithGoogle();
                Navigator.of(context)
                    .pushNamed("/add-username", arguments: userCredentials);
              },
            ),
            _renderSingupOptionBtn(
              "Register with email",
              Icons.email_outlined,
              () {
                Navigator.of(context).pushNamed("/register-with-email");
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
