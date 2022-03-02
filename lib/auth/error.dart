import 'package:coursecupid/core/blank.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key, required this.logoutAction, required this.message})
      : super(key: key);
  final VoidCallback logoutAction;
  final String message;

  @override
  Widget build(BuildContext context) {
    return EmptyPage(children: [
      Text(message),
      const SizedBox(height: 100.0),
      ElevatedButton(
          style: ElevatedButton.styleFrom(minimumSize: const Size(200, 48)),
          onPressed: logoutAction,
          child: const Text("Go Back")),
    ]);
  }
}
