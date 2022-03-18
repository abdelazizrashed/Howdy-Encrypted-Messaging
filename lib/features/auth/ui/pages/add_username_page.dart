import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:howdy/features/auth/bloc/blocs.dart';
import 'package:howdy/features/auth/models/models.dart';
import 'package:howdy/features/auth/services/services.dart';

class AddUsernamePage extends StatelessWidget {
  final UserCredential userCredential;
  const AddUsernamePage({Key? key, required this.userCredential})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add username"),
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
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            if (state is SetUserLoaded) {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed("/home");
            }
          },
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    hintText: "username",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                OutlinedButton(
                  onPressed: () async {
                    if (usernameController.text.isEmpty) {
                      Fluttertoast.showToast(msg: "username is empty");
                    } else {
                      var exists = await UserServices.checkIfUsernameExists(
                          usernameController.text);
                      if (exists) {
                        Fluttertoast.showToast(msg: "username already exists");
                        return;
                      }
                      UserModel user = UserModel(
                        displayName: userCredential.user?.displayName ?? "",
                        email: userCredential.user?.email ?? "",
                        photoURL: userCredential.user?.photoURL ?? '',
                        uid: userCredential.user?.uid ?? '',
                        username: usernameController.text,
                      );
                      context.read<UserBloc>().add(
                            SaveUserInDatabaseEvent(
                              user: user,
                            ),
                          );
                    }
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
                      "Done",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
