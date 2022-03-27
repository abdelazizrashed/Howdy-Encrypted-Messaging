import 'package:flutter/material.dart';

class SentMessage extends StatelessWidget {
  final String message;
  const SentMessage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: Colors.grey.shade700,
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
