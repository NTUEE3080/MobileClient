import 'package:coursecupid/core/debug.dart';
import 'package:flutter/material.dart';

class DebugLogo extends StatefulWidget {
  const DebugLogo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DebugLogoState();
}

class _DebugLogoState extends State<StatefulWidget> {
  int count = 0;

  void increment() => setState(() => count++);
  void resetCount() => setState(() => count = 0);

  void onTap() {
    increment();
    if(count == 7) {
      Navigator.push(context,  MaterialPageRoute(
          builder: (context) => const DebugScreen())
      );
      resetCount();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child:  Image.asset(
        'assets/cupid-arrow.png',
        height: 100,
        width: 100,
      ),
      onTap: onTap,
    );
  }
}
