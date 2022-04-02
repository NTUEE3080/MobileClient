import 'package:coursecupid/auth/frame.dart';
import 'package:coursecupid/core/animation.dart';
import 'package:coursecupid/core/api_service.dart';
import 'package:coursecupid/dynamic_theme/themes.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import './home.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var themes = await generateTheme();
  runApp(CourseCupidApp(theme: themes));
}

class CourseCupidApp extends StatelessWidget {
  const CourseCupidApp({Key? key, required this.theme}) : super(key: key);
  final ThemeCollection theme;

  @override
  Widget build(BuildContext context) {
    const eAim = AnimationPage(
        asset: LottieAnimations.lochness, text: "Error - Lochness Monster");
    const lAim =
        AnimationPage(asset: LottieAnimations.loading, text: "Loading...");

    return DynamicTheme(
      themeCollection: theme,
      defaultThemeId: AppThemes.Default,
      builder: (context, theme) {
        return OverlaySupport(
          child: AuthFrame(
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
                }),
          ),
        );
      },
    );
  }
}
