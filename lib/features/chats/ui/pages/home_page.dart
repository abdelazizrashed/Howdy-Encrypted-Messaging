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
        body: const TabBarView(
          children: [
            ChatsPage(),
            CallsPage(),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: TabBar(
            onTap: (tabIndex) {
              switch (tabIndex) {
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
            tabs: const [
              Tab(
                child: Icon(
                  Icons.message,
                  color: Colors.blue,
                ),
              ),
              Tab(
                child: Icon(
                  Icons.phone,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          shape: const CircularNotchedRectangle(),
          notchMargin: 5.0,
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
