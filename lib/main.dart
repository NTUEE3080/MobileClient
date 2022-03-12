import 'dart:convert';

import 'package:coursecupid/auth/frame.dart';
import 'package:coursecupid/core/animation.dart';
import 'package:coursecupid/core/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';

import './home.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeStr = await rootBundle.loadString('assets/theme_main.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;
  runApp(CourseCupidApp(theme: theme));
}

class CourseCupidApp extends StatelessWidget {
  const CourseCupidApp({Key? key, required this.theme}) : super(key: key);
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    const eAim = AnimationPage(
        asset: LottieAnimations.lochness, text: "Error - Lochness Monster");
    const lAim =
        AnimationPage(asset: LottieAnimations.loading, text: "Loading...");

    return AuthFrame(
        theme: theme,
        child: (login, logout, user, error) => FutureBuilder<ApiService>(
            future: ApiService.fromPlatform(),
            builder: (context, val) {
              if (val.connectionState == ConnectionState.done) {
                if (val.hasData) {
                  return HomeWidget(
                    user: user,
                    title: "Home",
                    logout: logout,
                    api: val.data!,
                  );
                }
                return eAim;
              }
              return lAim;
            }));
  }
}
