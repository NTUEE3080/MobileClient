import 'package:coursecupid/core/blank.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'debug_logo.dart';

class InitialHomePage extends StatelessWidget {
  const InitialHomePage(
      {Key? key, required this.loginAction, this.loginError = ''})
      : super(key: key);
  final VoidCallback loginAction;
  final String loginError;

  @override
  Widget build(BuildContext context) {
    return EmptyPage(children: [
      const DebugLogo(),
      const SizedBox(height: 24.0),
      Text(
        'Course Cupid',
        style: GoogleFonts.audiowide(
            textStyle: Theme.of(context).textTheme.headline4),
      ),
      const SizedBox(height: 100.0),
      ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(9.0)),
            minimumSize: const Size(200, 56),
            elevation: 0,
          ),
          onPressed: loginAction,
          child: Text(
            "Register",
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          )),
      const SizedBox(height: 30.0),
      TextButton(onPressed: loginAction, child: const Text("Login"))
    ]);
  }
}
