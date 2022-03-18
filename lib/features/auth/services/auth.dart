import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  //* Utilities

  static bool isLoggedIn() {
    return FirebaseAuth.instance.currentUser == null;
  }

  //* Auth using email and password

  Future<UserCredential> registerWithEmail(
    PlatformFile? avatar,
    String username,
    String displayName,
    String email,
    String password,
    BuildContext context,
  ) async {
    //This function is to register the user with email and password
    //It  authenticate the user in firebase and saves  her  data  in firestore.
    var userCreds = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return userCreds;
  }

  Future<UserCredential> loginWithEmail(
    String email,
    String password,
  ) async {
    var userCreds = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return userCreds;
  }

  //* Auth using google account
  Future<UserCredential> signinWithGoogle() async {
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
  }

  //TODO:  remove  later
  // //* Auth using phone number

  // static Future<void> registerUsingPhoneNumber(
  //   String phoneNumber,
  //   Function(User?) onSuccessCallback,
  //   Function(Function(String)) onCodeSent,
  // ) async {
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //     phoneNumber: phoneNumber,
  //     timeout: const Duration(minutes: 10),
  //     verificationCompleted: (PhoneAuthCredential credential) async {
  //       var currentUser = FirebaseAuth.instance.currentUser;
  //       if (currentUser != null) {
  //         await currentUser.updatePhoneNumber(credential);
  //         onSuccessCallback(currentUser);
  //       } else {
  //         var userCredentials =
  //             await FirebaseAuth.instance.signInWithCredential(credential);
  //         onSuccessCallback(userCredentials.user);
  //       }
  //     },
  //     verificationFailed: (FirebaseAuthException e) async {
  //       if (e.code == 'account-exists-with-different-credential') {
  //         Fluttertoast.showToast(
  //             msg: "User already exists with different authentication method.");
  //       }

  //       // Handle other OAuth providers...
  //     },
  //     codeSent: (String verificationId, int? resendToken) async {
  //       // Update the UI - wait for the user to enter the SMS code
  //       onCodeSent((smsCode) async {
  //         // Create a PhoneAuthCredential with the code
  //         PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //             verificationId: verificationId, smsCode: smsCode);

  //         // Sign the user in (or link) with the credential
  //         await FirebaseAuth.instance.signInWithCredential(credential);
  //       });
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {},
  //   );
  // }

  //* Logout
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
