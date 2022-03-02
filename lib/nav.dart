import "package:flutter/material.dart";

class NavigationButtonWidget extends StatelessWidget {
  const NavigationButtonWidget(
      {Key? key,
      required this.icon,
      required this.onPressed,
      required this.text,
      this.subtitle = ""})
      : super(key: key);
  final String text;
  final String subtitle;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: Icon(
                icon,
                semanticLabel: text,
                color: Theme.of(context).colorScheme.secondary,
                size: 50,
              )),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      text,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 8.0),
                    Text(subtitle),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
