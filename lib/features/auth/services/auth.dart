import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  //* Auth using email and password

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
