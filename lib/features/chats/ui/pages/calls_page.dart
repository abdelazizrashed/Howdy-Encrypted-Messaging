part of "home_page.dart";

class CallsPage extends StatelessWidget {
  const CallsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var calls = [
      {
        "img": "assets/imgs/empty_profile_photo.jpg",
        "name": "My Bro",
        "time": DateTime(2022, 3, 2, 5, 50, 23),
        "callStatus": CallStatus.recievedFailure,
        "callType": CallType.video
      },
      {
        "img": "assets/imgs/empty_profile_photo.jpg",
        "name": "Alex",
        "time": DateTime(2022, 2, 26, 13, 40, 33),
        "callStatus": CallStatus.recievedSuccess,
        "callType": CallType.video
      },
      {
        "img": "assets/imgs/empty_profile_photo.jpg",
        "name": "Sara",
        "time": DateTime(2021, 12, 2, 5, 50, 23),
        "callStatus": CallStatus.sentFailure,
        "callType": CallType.voice
      },
      {
        "img": "assets/imgs/empty_profile_photo.jpg",
        "name": "Ahmed",
        "time": DateTime(2021, 3, 2, 5, 50, 23),
        "callStatus": CallStatus.sentSuccess,
        "callType": CallType.voice
      }
    ];
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView.builder(
        itemCount: calls.length,
        itemBuilder: (BuildContext context, int index) {
          return CallCard(call: calls[index]);
        },
      ),
    );
  }
}


