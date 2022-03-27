import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:howdy/features/chats/bloc/blocs.dart';
import 'package:howdy/route_generator.dart';

import 'features/auth/bloc/blocs.dart';

class App extends StatelessWidget {
  final bool isLoggedIn;
  const App({Key? key, required this.isLoggedIn}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => UserBloc(),
        ),
        BlocProvider(
          create: (context) => SearchBloc(),
        ),
        BlocProvider(
          create: (context) => FriendsListBloc(),
        ),
        BlocProvider(
          create: (context) => SearchFriendsListBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Howdy: Encrypted messaging app',
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        initialRoute: isLoggedIn ? "/home" : "/auth",
        // initialRoute: "/home",
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
