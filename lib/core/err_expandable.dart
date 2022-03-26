import 'dart:math';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class ErrorViewer extends StatelessWidget {
  const ErrorViewer({Key? key, required this.errorTitle, required this.details})
      : super(key: key);

  final String errorTitle;
  final String details;

  @override
  Widget build(BuildContext context) {
    var t = Theme.of(context);
    var cs = t.colorScheme;
    return Container(
      color: cs.error,
      padding: const EdgeInsets.all(8),
      width: min(MediaQuery.of(context).size.width * 0.9, 400),
      child: ExpandablePanel(
          header: Text(errorTitle,
              textAlign: TextAlign.center,
              style: t.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold, color: t.colorScheme.onError)),
          collapsed: Text(
            "Details", style: t.textTheme.overline?.copyWith(
            color: t.colorScheme.onError,
                fontSize: 16,
          ),
          ),
          expanded: Text(details,
              style: t.textTheme.bodySmall?.copyWith(color: t.colorScheme.onError))),
    );
  }
}