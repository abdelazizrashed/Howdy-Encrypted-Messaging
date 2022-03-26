import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:howdy/features/auth/ui/pages/pages.dart';
import 'package:howdy/features/chats/models/friend_list_item_model.dart';
import 'package:howdy/features/chats/ui/pages/chat_room_page.dart';
import 'package:howdy/features/chats/ui/pages/pages.dart';

class RouteGenerator {
  static Route generateRoute(RouteSettings settings) {
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
      case '/search-users':
        return MaterialPageRoute(builder: (_) => const SearchUsersPage());
      case "/chat-room":
        final args = settings.arguments as FriendListItemModel;
        return MaterialPageRoute(
            builder: (_) => ChatRoomPage(friendListItem: args));
      default:
        if (FirebaseAuth.instance.currentUser == null) {
          return MaterialPageRoute(builder: (_) => const AuthOptionsPage());
        }
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
    // throw Exception("No Route");
  }
}
