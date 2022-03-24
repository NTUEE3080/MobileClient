import 'package:coursecupid/core/resp_ext.dart';
import 'package:coursecupid/dynamic_theme/themes.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';

class ThemeInfo {
  final String name;
  final Color color;
  final int id;

  ThemeInfo(this.name, this.color, this.id);
}

class ThemeSetting extends StatefulWidget {
  final TextEditingController controller;

  const ThemeSetting({Key? key, required this.controller}) : super(key: key);

  @override
  State<ThemeSetting> createState() => _ThemeSettingState();
}

class _ThemeSettingState extends State<ThemeSetting> {
  List<ThemeInfo> fullList = [
    ThemeInfo(
        "Cupid", const Color.fromRGBO(0xef, 0x9a, 0x9a, 1), AppThemes.Default),
    ThemeInfo("Dark Forest", const Color.fromRGBO(0x10, 0x57, 0x4f, 1),
        AppThemes.DarkForest),
    ThemeInfo(
        "Dark", const Color.fromRGBO(0x12, 0x12, 0x12, 1), AppThemes.Dark),
  ];
  List<ThemeInfo> filteredList = [];
  String _searchTerm = "";

  _searchListener() {
    if (widget.controller.text.isEmpty) {
      setState(() {
        _searchTerm = "";
        filteredList = List.from(fullList);
      });
    } else {
      setState(() {
        _searchTerm = widget.controller.text;
        filteredList =
            fullList.where((x) => _searchTerm.lowerCompare(x.name)).toList();
      });
    }
  }

  @override
  didUpdateWidget(Widget oldWidget) {
    filteredList = fullList;
    widget.controller.addListener(_searchListener);
    super.didUpdateWidget(oldWidget as ThemeSetting);
  }

  @override
  void initState() {
    filteredList = fullList;
    widget.controller.addListener(_searchListener);
    super.initState();
  }

  generateOnTap(BuildContext context, int target) {
    return () {
      DynamicTheme.of(context)!.setTheme(target);
    };
  }

  @override
  Widget build(BuildContext context) {
    var t = DynamicTheme.of(context)!;
    var current = t.themeId;

    return GridView.count(
        crossAxisCount: 3,
        children: filteredList
            .map((e) => ThemeButton(
                onTap: generateOnTap(context, e.id),
                selected: current == e.id,
                color: e.color,
                name: e.name))
            .toList());
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
