import 'package:coursecupid/core/blank.dart';
import 'package:flutter/material.dart';

class VerifyEmailPage extends StatelessWidget {
  const VerifyEmailPage(
      {Key? key,
      required this.refresh,
      required this.logout,
      required this.message})
      : super(key: key);
  final VoidCallback refresh;
  final VoidCallback logout;
  final String message;

  @override
  Widget build(BuildContext context) {
    return EmptyPage(children: [
      Text(message),
      const SizedBox(height: 100.0),
      ElevatedButton.icon(
          icon: const Icon(Icons.restart_alt),
          style: ElevatedButton.styleFrom(minimumSize: const Size(200, 48)),
          onPressed: refresh,
          label: const Text("Refresh")),
      const SizedBox(height: 20.0),
      TextButton(onPressed: logout, child: const Text("Go Back"))
    ]);
  }
}
