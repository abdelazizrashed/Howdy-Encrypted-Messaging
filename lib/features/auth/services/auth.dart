import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:howdy/features/auth/models/models.dart';
import 'package:howdy/features/auth/services/services.dart';

class AuthServices {
  //* Auth using email and password

  static Future<void> registerWithEmail(
    PlatformFile? avatar,
    String username,
    String displayName,
    String email,
    String password,
    BuildContext context,
  ) async {
    String photoURL = "";
    if (avatar != null) {
      var uploadTask = await FirebaseStorage.instance
          .ref("avatars/$username/$username.${avatar.extension ?? "png"}")
          .putFile(File(avatar.path ?? ""));
      photoURL = await uploadTask.ref.getDownloadURL();
    } else {
      photoURL =
          "https://firebasestorage.googleapis.com/v0/b/howdy-f2c44.appspot.com/o/avatars%2Fempty_profile_photo.jpg?alt=media&token=6f58ee29-7dfd-436b-9660-0f6462d02048";
    }
    var userCreds = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    UserModel user = UserModel(
      displayName: displayName,
      email: email,
      photoURL: photoURL,
      uid: userCreds.user?.uid ?? "",
      username: username,
    );
    UserServices.saveUserInDatabase(user);
    UserServices.setUserLoggedIn(user);
  }

  static Future<UserCredential> loginWithEmail(
    String email,
    String password,
  ) async {
    var userCreds = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    // .createUserWithEmailAndPassword(email: email, password: password);
    return userCreds;
  }

  //* Auth using google account
  static Future<UserCredential> signinWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);

    // return[existingUser, ]
  }

  //* Auth using phone number

  static Future<void> registerUsingPhoneNumber(
    String phoneNumber,
    Function(User?) onSuccessCallback,
    Function(Function(String)) onCodeSent,
  ) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(minutes: 10),
      verificationCompleted: (PhoneAuthCredential credential) async {
        var currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser != null) {
          await currentUser.updatePhoneNumber(credential);
          onSuccessCallback(currentUser);
        } else {
          var userCredentials =
              await FirebaseAuth.instance.signInWithCredential(credential);
          onSuccessCallback(userCredentials.user);
        }
      },
      verificationFailed: (FirebaseAuthException e) async {
        if (e.code == 'account-exists-with-different-credential') {
          Fluttertoast.showToast(
              msg: "User already exists with different authentication method.");
        }

        // Handle other OAuth providers...
      },
      codeSent: (String verificationId, int? resendToken) async {
        // Update the UI - wait for the user to enter the SMS code
        onCodeSent((smsCode) async {
          // Create a PhoneAuthCredential with the code
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: smsCode);

          // Sign the user in (or link) with the credential
          await FirebaseAuth.instance.signInWithCredential(credential);
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  //* Logout

}
