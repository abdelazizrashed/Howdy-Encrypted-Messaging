part of "home_page.dart";

class ChatsPage extends StatelessWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var msgs = [
      {
        "img": "assets/imgs/empty_profile_photo.jpg",
        "name": "My Bro",
        "time": DateTime(2022, 3, 2, 5, 50, 23),
        "message": "Hi",
        "messageStatus": MessageStatus.recieved
      },
      {
        "img": "assets/imgs/empty_profile_photo.jpg",
        "name": "Alex",
        "time": DateTime(2022, 2, 26, 13, 40, 33),
        "message": "Hi",
        "messageStatus": MessageStatus.read
      },
      {
        "img": "assets/imgs/empty_profile_photo.jpg",
        "name": "Sara",
        "time": DateTime(2021, 12, 2, 5, 50, 23),
        "message": "Hi",
        "messageStatus": MessageStatus.notRecieved
      },
      {
        "img": "assets/imgs/empty_profile_photo.jpg",
        "name": "Ahmed",
        "time": DateTime(2021, 3, 2, 5, 50, 23),
        "message":
            '''Diam volutpat commodo sed egestas. Aliquet eget sit amet tellus cras. Accumsan sit amet nulla facilisi morbi tempus. Id donec ultrices tincidunt arcu non sodales neque. Purus ut faucibus pulvinar elementum integer enim neque volutpat ac. Felis imperdiet proin fermentum leo vel. Ac tortor dignissim convallis aenean et tortor at risus. Non odio euismod lacinia at quis risus. Aliquet sagittis id consectetur purus ut faucibus.''',
        "messageStatus": MessageStatus.sent
      }
    ];
    msgs.sort(
      (b, a) => (a["time"] as DateTime).compareTo(b["time"] as DateTime),
    );
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView.builder(
        itemCount: msgs.length,
        itemBuilder: (context, index) {
          return MessageCard(msg: msgs[index]);
        },
      ),
    );
  }
}
