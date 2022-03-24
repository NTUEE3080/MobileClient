import 'package:coursecupid/dynamic_theme/themes.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';

class ThemeSetting extends StatelessWidget {
  const ThemeSetting({Key? key}) : super(key: key);

  generateOnTap(BuildContext context, int target) {
    return () {
      DynamicTheme.of(context)!.setTheme(target);
    };
  }

  @override
  Widget build(BuildContext context) {
    var t = DynamicTheme.of(context)!;
    var current = t.themeId;

    return GridView.count(crossAxisCount: 3, children: [
      ThemeButton(
        color: const Color.fromRGBO(0xef, 0x9a, 0x9a, 1),
        onTap: generateOnTap(context, AppThemes.Default),
        name: "Cupid",
        selected: AppThemes.Default == current,
      ),
      ThemeButton(
        color: const Color.fromRGBO(0x10, 0x57, 0x4f, 1),
        onTap: generateOnTap(context, AppThemes.DarkForest),
        name: "Dark forest",
        selected: AppThemes.DarkForest == current,
      ),
      ThemeButton(
        color: const Color.fromRGBO(0x12, 0x12, 0x12, 1),
        onTap: generateOnTap(context, AppThemes.Dark),
        name: "Dark",
        selected: AppThemes.Dark == current,
      )
    ]);
  }
}

class ThemeButton extends StatelessWidget {
  final void Function() onTap;
  final bool selected;
  final Color color;
  final String name;

  const ThemeButton(
      {Key? key,
      required this.onTap,
      required this.selected,
      required this.color,
      required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var t = Theme.of(context);
    return Card(
      elevation: 6,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: color,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Text(
                name,
                style: t.textTheme.titleLarge,
              ),
            )
          ],
        ),
      ),
    );
  }
}
