import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:howdy/features/chats/models/models.dart';

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
            onPressed: () {},
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
              onPressed: () {
                //Todo:Go to settings page
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
        bottomNavigationBar: BottomNavigationBar(
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
