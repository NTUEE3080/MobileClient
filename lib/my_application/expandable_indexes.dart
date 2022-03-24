import 'package:coursecupid/api_lib/swagger.swagger.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import 'index_row.dart';

class ExpandableIndex extends StatelessWidget {
  final String? title;
  final List<IndexPrincipalRes> indexes;
  final double inset;

  const ExpandableIndex(
      {Key? key, this.title, required this.indexes, this.inset = 16.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var t = Theme.of(context);
    var cs = t.colorScheme;
    var text = title == null
        ? const SizedBox(height: 4)
        : Text(
            title!,
            style: t.textTheme.overline,
    );
    return Column(
      children: [
        text,
        ...indexes
            .map((e) => ExpandablePanel(
                  header: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: inset, vertical: inset),
                      child: Text(
                        e.code ?? "Unknown Index",
                        style: t.textTheme.titleMedium?.copyWith(
                          color: cs.secondary,
                          // fontWeight: FontWeight.bold,
                        ),
                      )),
                  collapsed: const Center(),
                  expanded: Column(
                    children: [
                      ...?e.props?.map((e) => IndexRowView(prop: e)).toList()
                    ],
                  ),
                ))
            .toList(),
      ],
    );
  }
}
