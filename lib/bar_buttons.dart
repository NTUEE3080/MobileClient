import 'package:flutter/material.dart';

class TopBarTab extends StatelessWidget {
  final IconData icon;
  final String text;

  const TopBarTab({Key? key, required this.icon, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        Text(
          text,
          style: TextStyle(
              height: 0, color: Theme.of(context).colorScheme.onPrimary),
        )
      ],
    );
  }
}

class BottomBarButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const BottomBarButton(
      {Key? key,
      required this.icon,
      required this.text,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(
            icon,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          onPressed: onPressed,
        ),
        Text(
          text,
          style: TextStyle(
              height: 0, color: Theme.of(context).colorScheme.onPrimary),
        )
      ],
    );
  }
}
