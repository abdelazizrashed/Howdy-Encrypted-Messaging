import 'package:flutter/material.dart';
import 'package:howdy/features/chats/models/models.dart';

import '../widgets/widgets.dart';

part 'chats_page.dart';
part 'calls_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Howdy Messanger"),
            actions: [
              IconButton(
                onPressed: () {
                  //Todo:Go to settings page
                },
                icon: const Icon(Icons.settings),
              ),
            ],
            bottom: TabBar(
              onTap: (tabIndex) {
                //Todo: do something
              },
              tabs: const [
                Tab(text: "CHATS"),
                Tab(text: "CALLS"),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              ChatsPage(),
              CallsPage(),
            ],
          )),
    );
  }
}
