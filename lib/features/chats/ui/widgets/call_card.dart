import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/models.dart';
import 'dart:math' as math;

class CallCard extends StatelessWidget {
  const CallCard({
    Key? key,
    required this.call,
  }) : super(key: key);

  final Map<String, Object> call;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            child: SizedBox(
              width: 60,
              height: 60,
              child: Image(
                image: AssetImage(call["img"] as String),
                fit: BoxFit.fill,
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
                              call["name"] as String,
                              style: const TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: _onCallCardTapped,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              _renderCallStatusArrow(
                                call["callStatus"] as CallStatus,
                              ),
                              Text(
                                DateFormat("d MMMM y, H:m")
                                    .format(call["time"] as DateTime),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  _renderCallBtn(call["callType"] as CallType)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Transform _renderCallStatusArrow(CallStatus callStatus) {
    switch (callStatus) {
      case CallStatus.recievedFailure:
        return Transform.rotate(
          angle: (135) * math.pi / 180,
          child: const Icon(
            Icons.arrow_right_alt_sharp,
            color: Colors.red,
          ),
        );

      case CallStatus.recievedSuccess:
        return Transform.rotate(
          angle: (135) * math.pi / 180,
          child: const Icon(
            Icons.arrow_right_alt_sharp,
            color: Colors.green,
          ),
        );
      case CallStatus.sentSuccess:
        return Transform.rotate(
          angle: (-45) * math.pi / 180,
          child: const Icon(
            Icons.arrow_right_alt_sharp,
            color: Colors.green,
          ),
        );
      case CallStatus.sentFailure:
        return Transform.rotate(
          angle: (-45) * math.pi / 180,
          child: const Icon(
            Icons.arrow_right_alt_sharp,
            color: Colors.red,
          ),
        );
    }
  }
}

IconButton _renderCallBtn(CallType callType) {
  if (callType == CallType.video) {
    return IconButton(
      icon: const Icon(
        Icons.videocam,
        color: Colors.grey,
      ),
      onPressed: () {
        //Todo: implement call functionality
      },
    );
  } else {
    return IconButton(
      icon: const Icon(
        Icons.call,
        color: Colors.grey,
      ),
      onPressed: () {
        //Todo: implement call functionality
      },
    );
  }
}

void _onCallCardTapped() {
  //Todo: Implement this function
}
