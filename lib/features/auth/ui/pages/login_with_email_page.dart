import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:howdy/features/auth/services/services.dart';

import '../../bloc/blocs.dart';

class LoginWithEmailPage extends StatefulWidget {
  const LoginWithEmailPage({Key? key}) : super(key: key);

  @override
  State<LoginWithEmailPage> createState() => _LoginWithEmailPageState();
}

class _LoginWithEmailPageState extends State<LoginWithEmailPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login with email"),
        centerTitle: true,
        toolbarHeight: 70,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) async {
                  if (state is LoggedIn) {
                    var userCreds = state.userCredential;
                    var exists = await UserServices.checkIfUserExists(
                        userCreds.user?.uid ?? "");
                    if (exists) {
                      var user = await UserServices.getUserFromDatabase(
                          userCreds.user?.uid ?? "");
                      UserServices.setUserLoggedIn(user);
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed("/home");
                    } else {
                      Fluttertoast.showToast(
                          msg: "Something went wrong. Try again");
                    }
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return SingleChildScrollView(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextField(
                          controller: emailController,
                          decoration: const InputDecoration(hintText: "Email"),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          obscureText: true,
                          controller: passwordController,
                          decoration:
                              const InputDecoration(hintText: "Password"),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        OutlinedButton(
                          onPressed: () async {
                            if (emailController.text.isEmpty) {
                              Fluttertoast.showToast(msg: "Email is required");
                              return;
                            }

                            if (passwordController.text.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "Password is required");
                              return;
                            }
                            setState(() {
                              isLoading = true;
                            });
                            context.read<AuthBloc>().add(
                                  LoginWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  ),
                                );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
