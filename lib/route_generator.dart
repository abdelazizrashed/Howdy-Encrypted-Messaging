import 'package:flutter/material.dart';
import 'package:howdy/features/auth/ui/pages/pages.dart';
import 'package:howdy/features/chats/ui/pages/pages.dart';



class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //get the argument that have been passed with the route
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/auth':
        return MaterialPageRoute(builder: (_) => const AuthOptionsPage());
      // case '/today':
      //   return MaterialPageRoute(builder: (_) => TodayPage());
      // case '/projectsTasks':
      //   return MaterialPageRoute(
      //       builder: (_) => ProjectsTasksPage(project: args));
      // case '/history':
      //   return MaterialPageRoute(builder: (_) => HistoryPage());
      default:
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
  }
}