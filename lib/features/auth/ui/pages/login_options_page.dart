import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:howdy/features/auth/ui/widgets/widgets.dart';

import '../../bloc/blocs.dart';
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
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) async {
                if (state is LoggedIn) {
                  var userCredentials = state.userCredential;
                  bool isNewUser =
                      userCredentials.additionalUserInfo?.isNewUser ?? true;
                  if (isNewUser) {
                    Navigator.of(context)
                        .pushNamed("/add-username", arguments: userCredentials);
                  } else if (userCredentials.user != null) {
                    var userExists = await UserServices.checkIfUserExists(
                        userCredentials.user?.uid ?? "");
                    if (!userExists) {
                      Navigator.of(context).pushNamed("/add-username",
                          arguments: userCredentials);
                    } else {
                      BlocProvider.of<UserBloc>(context).add(
                        GetUserFromDatabaseEvent(
                          userCredentials.user?.uid ?? "",
                        ),
                      );
                    }
                  } else {
                    Fluttertoast.showToast(
                        msg: "Something went wrong. Try again.");
                  }
                }
              },
              child: BlocListener<UserBloc, UserState>(
                listener: (context, state) {
                  if (state is GetUserLoaded) {
                    BlocProvider.of<UserBloc>(context).add(
                      SetUserLoggedInEvent(
                        state.user,
                      ),
                    );
                  } else if (state is SetUserLoaded) {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed("/home");
                  }
                },
                child: SignupLoginOptionBtn(
                  lbl: "Login with google account",
                  icon: FontAwesomeIcons.google,
                  callback: () async {
                    if (AuthServices.isLoggedIn()) {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed("/home");
                    } else {
                      BlocProvider.of<AuthBloc>(context)
                          .add(const LoginWithGoogleEvent());
                    }
                  },
                ),
              ),
            ),
            SignupLoginOptionBtn(
              lbl: "Login with email",
              icon: Icons.email_outlined,
              callback: () {
                Navigator.of(context).pushNamed("/login-with-email");
              },
            ),
          ],
        ),
      ),
    );
  }
}
