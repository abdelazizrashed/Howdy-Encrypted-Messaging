import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:howdy/features/auth/bloc/blocs.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:howdy/features/auth/ui/widgets/widgets.dart';

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
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is LoggedIn) {
                  Navigator.of(context).pushNamed("/add-username",
                      arguments: state.userCredential);
                }
              },
              child: SignupLoginOptionBtn(
                lbl: "Register with google account",
                icon: FontAwesomeIcons.google,
                callback: () {
                  context.read<AuthBloc>().add(const LoginWithGoogle());
                },
              ),
            ),
            SignupLoginOptionBtn(
              lbl: "Register with email",
              icon: Icons.email_outlined,
              callback: () {
                Navigator.of(context).pushNamed("/register-with-email");
              },
            ),
          ],
        ),
      ),
    );
  }
}
