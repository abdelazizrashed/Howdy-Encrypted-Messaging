import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  //* Utilities

  static bool isLoggedIn() {
    return FirebaseAuth.instance.currentUser != null;
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

  
  //* Logout
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
