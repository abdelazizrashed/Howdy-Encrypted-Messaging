import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:howdy/features/auth/ui/pages/pages.dart';
import 'package:howdy/features/chats/ui/pages/pages.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //get the argument that have been passed with the route

    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/auth':
        return MaterialPageRoute(builder: (_) => const AuthOptionsPage());
      case "/signup-options":
        return MaterialPageRoute(builder: (_) => const SignupOptionsPage());
      case "/login-options":
        return MaterialPageRoute(builder: (_) => const LoginOptionsPage());
      case "/add-phone-number":
        return MaterialPageRoute(builder: (_) => const AddPhoneNumberPage());
      case "/add-username":
        final args = settings.arguments as UserCredential;
        return MaterialPageRoute(
            builder: (_) => AddUsernamePage(userCredential: args));
      case "/register-with-email":
        return MaterialPageRoute(builder: (_) => const RegisterWithEmailPage());
      case "/login-with-email":
        return MaterialPageRoute(builder: (_) => const LoginWithEmailPage());
      default:
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
    // throw Exception("No Route");
  }
}
