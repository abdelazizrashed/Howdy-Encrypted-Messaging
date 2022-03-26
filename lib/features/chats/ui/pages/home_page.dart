import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:howdy/features/chats/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/widgets.dart';

part 'chats_page.dart';
part 'calls_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String appBarTitle = "Messages";
  IconData addIcon = FontAwesome5.edit;
  int _page = 0;
  late PageController pageController = PageController(initialPage: _page);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/search-users");
            },
            icon: const Icon(
              Icons.search,
            ),
          ),
          centerTitle: true,
          toolbarHeight: 70,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ),
          ),
          elevation: 0,
          title: Text(appBarTitle),
          actions: [
            IconButton(
              onPressed: () async {
                //TODO:Go to settings page
                await FirebaseAuth.instance.signOut();
                await (await SharedPreferences.getInstance())
                    .setBool("isLoggedIn", false);
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed("/auth");
              },
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
        body: PageView(
          controller: pageController,
          onPageChanged: (newPage) {
            setState(() {
              _page = newPage;
            });
            switch (newPage) {
              case 0:
                setState(() {
                  appBarTitle = "Messages";
                  addIcon = FontAwesome5.edit;
                });
                break;
              case 1:
                setState(() {
                  appBarTitle = "Calls";
                  addIcon = Icons.add_call;
                });
                break;
            }
          },
          children: const [
            ChatsPage(),
            CallsPage(),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Theme.of(context).primaryColor.withAlpha(0),
            selectedItemColor: Theme.of(context).colorScheme.onSurface,
            // backgroundColor: Colors.white,
            currentIndex: _page,
            items: const [
              BottomNavigationBarItem(
                label: "CHATS",
                icon: Icon(
                  Icons.message,
                  color: Colors.blue,
                ),
              ),
              BottomNavigationBarItem(
                label: "CALLS",
                icon: Icon(
                  Icons.phone,
                  color: Colors.blue,
                ),
              ),
            ],
            onTap: (tabIndex) {
              pageController.animateToPage(tabIndex,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(
            addIcon,
          ),
        ),
      ),
    );
  }
}
