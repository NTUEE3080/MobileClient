import 'package:flutter/material.dart';

import '../api_lib/swagger.swagger.dart';
import '../my_application/index_row.dart';

class CreateApplicationHeader extends StatelessWidget {
  final PostPrincipalResp? p;

  const CreateApplicationHeader({Key? key, required this.p}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var t = Theme.of(context);
    var cs = t.colorScheme;
    return Column(
      children: [
        ...?p?.index?.props?.map((e) => IndexRowView(prop: e)),
        const Divider(
          height: 12,
          thickness: 1,
          indent: 0,
          endIndent: 0,
        ),
        ListTile(
          title: Text(
            "Looking For",
            style: t.textTheme.overline,
          ),
          subtitle: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Wrap(
              spacing: 8,
              runSpacing: 4,
              children: (p?.lookingFor?.map((e) => Chip(
                          backgroundColor: cs.primary,
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10))),
                          label: Text(
                            e.code ?? "Unknown Index",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: cs.onPrimary),
                          ))) ??
                      [])
                  .toList(),
            ),
          ),
        ),
        const Divider(
          height: 12,
          thickness: 1,
          indent: 0,
          endIndent: 0,
        ),
      ],
    );
  }
}
