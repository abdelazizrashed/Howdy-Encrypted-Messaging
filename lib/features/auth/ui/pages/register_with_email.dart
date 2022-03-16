import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:howdy/core/utilities/is_password_strong_enough.dart';
import 'package:howdy/features/auth/services/services.dart';

class RegisterWithEmailPage extends StatefulWidget {
  const RegisterWithEmailPage({Key? key}) : super(key: key);

  @override
  State<RegisterWithEmailPage> createState() => _RegisterWithEmailPageState();
}

class _RegisterWithEmailPageState extends State<RegisterWithEmailPage> {
  PlatformFile? avatar;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    TextEditingController displayNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rgister with email"),
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
            : SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        // print("hello");
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          allowMultiple: false,
                          type: FileType.custom,
                          allowedExtensions: ['jpg', 'png', 'jpeg', "svg"],
                        );
                        if (result != null) {
                          // print(result.files.first.);
                          setState(() {
                            avatar = result.files.first;
                          });
                        }
                      },
                      child: _renderUserAvatar(avatar?.path),
                    ),
                    TextField(
                      controller: displayNameController,
                      decoration:
                          const InputDecoration(hintText: "Display name"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(hintText: "Email"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: usernameController,
                      decoration: const InputDecoration(hintText: "Username"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: const InputDecoration(hintText: "Password"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      obscureText: true,
                      controller: confirmPasswordController,
                      decoration:
                          const InputDecoration(hintText: "Confirm password"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    OutlinedButton(
                      onPressed: () async {
                        if (displayNameController.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Display name is required");
                          return;
                        }
                        if (emailController.text.isEmpty) {
                          Fluttertoast.showToast(msg: "Email is required");
                          return;
                        }
                        if (usernameController.text.isEmpty) {
                          Fluttertoast.showToast(msg: "Username is required");
                          return;
                        }
                        var exists = await UserServices.checkIfUsernameExists(
                            usernameController.text);
                        if (exists) {
                          Fluttertoast.showToast(
                              msg: "username already exists");
                          return;
                        }

                        if (passwordController.text.isEmpty) {
                          Fluttertoast.showToast(msg: "Password is required");
                          return;
                        }
                        if (confirmPasswordController.text.isEmpty) {
                          Fluttertoast.showToast(msg: "You need to confirm the password");
                          return;
                        }
                        if (!isPasswordStrongEnough(passwordController.text)) {
                          Fluttertoast.showToast(msg: "The password is weak");
                          return;
                        }
                        if (passwordController.text !=
                            confirmPasswordController.text) {
                          Fluttertoast.showToast(msg: "Password is wrong");
                          return;
                        }
                        setState(() {
                          isLoading = true;
                        });
                        AuthServices.registerWithEmail(
                          avatar,
                          usernameController.text,
                          displayNameController.text,
                          emailController.text,
                          passwordController.text,
                          context,
                        );

                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed("/home");
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
                          "Register",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  ClipRRect _renderUserAvatar(String? avatarPath) {
    if (avatarPath == null) {
      return const ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(100)),
        child: SizedBox(
          width: 150,
          height: 150,
          child: Image(
            image: AssetImage("assets/imgs/empty_profile_photo.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        child: SizedBox(
          width: 150,
          height: 150,
          child: Image(
            image: FileImage(File(avatarPath)),
            fit: BoxFit.cover,
          ),
        ),
      );
    }
  }
}
