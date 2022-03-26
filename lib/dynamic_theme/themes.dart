import 'dart:convert';

import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';

class AppThemes {
  static const int Default = 0;
  static const int DarkForest = 1;
  static const int StarryNight = 2;
  static const int Dark = 3;
}

Future<ThemeData> loadFromString(String s) async {
  final themeStr = await rootBundle.loadString(s);
  final themeJson = jsonDecode(themeStr);
  return ThemeDecoder.decodeThemeData(themeJson)!;
}

Future<ThemeCollection> generateTheme() async {
  var def = await loadFromString('assets/theme_main.json');
  var darkForest = await loadFromString('assets/theme/dark_forest.json');
  var starryNight = await loadFromString('assets/theme/stary_night.json');
  return ThemeCollection(
    themes: {
      AppThemes.Default: def,
      AppThemes.DarkForest: darkForest,
      AppThemes.StarryNight: starryNight,
      AppThemes.Dark: ThemeData.dark(),
    },
    fallbackTheme: ThemeData.light(),
  );
}
