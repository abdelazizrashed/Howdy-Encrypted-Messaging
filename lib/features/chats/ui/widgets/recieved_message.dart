import 'package:flutter/material.dart';

class RecievedMessage extends StatelessWidget {
  final String message;
  const RecievedMessage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Colors.green,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message,
            ),
          ),
        ),
      ),
    );
  }
}
