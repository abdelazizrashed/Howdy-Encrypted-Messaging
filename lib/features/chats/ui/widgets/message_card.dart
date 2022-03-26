import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:howdy/features/chats/models/message_status.dart';

class MessageCard extends StatelessWidget {
  final Map<String, Object> msg;

  const MessageCard({Key? key, required this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //TODO: do something here
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(100)),
              child: SizedBox(
                width: 60,
                height: 60,
                child: Image(
                  image: AssetImage(msg["img"] as String),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          FractionallySizedBox(
                            widthFactor: 1,
                            child: GestureDetector(
                              onTap: _onCallCardTapped,
                              child: Text(
                                msg["name"] as String,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: _onCallCardTapped,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: _renderMsgStatusIcon(
                                        msg["messageStatus"] as MessageStatus),
                                  ),
                                  Flexible(
                                    child: Text(
                                      msg["message"] as String,
                                      maxLines: 2,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Icon _renderMsgStatusIcon(MessageStatus messageStatus) {
    switch (messageStatus) {
      case MessageStatus.notRecieved:
        return const Icon(
          FontAwesome5.check,
          color: Colors.grey,
          size: 13,
        );
      case MessageStatus.recieved:
        return const Icon(
          FontAwesome5.check_double,
          color: Colors.grey,
          size: 13,
        );
      case MessageStatus.read:
        return const Icon(
          FontAwesome5.check_double,
          color: Colors.blue,
          size: 13,
        );
      case MessageStatus.sent:
        return const Icon(
          null,
          size: 13,
        );
    }
  }
}

void _onCallCardTapped() {
  //TODO: Implement this function
}
