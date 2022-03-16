import 'package:coursecupid/api_lib/swagger.swagger.dart';
import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  final IconData icon;
  final String text;

  const IconText({Key? key, required this.icon, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 16),
        const SizedBox(width: 4),
        Text(text),
      ],
    );
  }
}

class IndexRowView extends StatelessWidget {
  final IndexPropsRes prop;

  const IndexRowView({Key? key, required this.prop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var t = Theme.of(context);
    var cs = t.colorScheme;
    return ListTile(
      title: Row(
        children: [
          Text(
            '${prop.group ?? "Unknown Group"} ',
            style: t.textTheme.overline?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            prop.type ?? "Unknown Type",
            style: t.textTheme.overline,
          ),
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconText(
              icon: Icons.event,
              text:
                  "${prop.day?.substring(0, 3)}: ${prop.start} - ${prop.stop}"),
          IconText(icon: Icons.place, text: prop.venue ?? "Unknown Venue"),
        ],
      ),
    );
  }
}

// Text(
// prop.type ?? "Unknown Group",
// style: t.textTheme.overline,
// ),
// OutlinedButton.icon(
// onPressed: () {},
// label: Text("${prop.day}: ${prop.start} - ${prop.stop}"),
// icon: const Icon(Icons.access_time_rounded)),
// Chip(
// label: Text(
// prop.venue ?? "Unknown Venue",
// style: TextStyle(
// color: cs.onSecondary,
// ),
// ),
// backgroundColor: cs.secondary)
// ],
