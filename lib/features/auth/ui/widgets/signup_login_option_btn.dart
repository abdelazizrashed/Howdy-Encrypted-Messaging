import 'package:flutter/material.dart';

class SignupLoginOptionBtn extends StatelessWidget {
  final String lbl;
  final IconData icon;
  final Function()? callback;
  const SignupLoginOptionBtn({
    Key? key,
    required this.lbl,
    required this.icon,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(350, 50),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
        ),
        onPressed: callback,
        label: Text(
          lbl,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        icon: Icon(icon),
      ),
    );
  }
}
