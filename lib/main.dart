import 'package:coursecupid/auth/frame.dart';
import 'package:flutter/material.dart';

import './home.dart';

void main() {
  runApp(const CourseCupidApp());
}

class CourseCupidApp extends StatelessWidget {
  const CourseCupidApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthFrame(child: (login, logout, error) =>
    HomeWidget(title: "Another Home", logout: logout,)
    );
  }

  
}

