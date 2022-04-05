import 'package:coursecupid/my_application/expandable_indexes.dart';
import 'package:flutter/material.dart';

import '../api_lib/swagger.swagger.dart';

class SinglePostWidget extends StatefulWidget {
  final PostPrincipalResp post;
  final IndexPrincipalRes have;
  final List<IndexPrincipalRes> lookingFor;
  final Future<void> Function(String?) create;

  const SinglePostWidget(
      {Key? key,
      required this.post,
      required this.lookingFor,
      required this.have,
      required this.create})
      : super(key: key);

  @override
  State<SinglePostWidget> createState() => _SinglePostWidgetState();
}

class _SinglePostWidgetState extends State<SinglePostWidget> {
  bool opened = false;

  @override
  Widget build(BuildContext context) {
    var t = Theme.of(context);
    var cs = t.colorScheme;
    var overline = t.textTheme.overline;

    var collapsed = ButtonBar(
      children: [
        ElevatedButton.icon(
            onPressed: () {
              setState(() => opened = true);
            },
            style: ElevatedButton.styleFrom(
                textStyle: t.textTheme.bodyMedium,
                minimumSize: const Size(100, 48)),
            icon: const Icon(Icons.swap_calls),
            label: const Text("Offer to Trade")),
      ],
    );
    var tradable = widget.post.index?.code != widget.have.code;
    var expanded = Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text("Trade Details", style: t.textTheme.titleLarge)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text("Giving", style: overline)),
                toChip(cs.secondary, cs.onSecondary, widget.post.index?.code),
              ],
            ),
            const Icon(Icons.arrow_forward),
            Column(
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text("Getting", style: overline)),
                toChip(cs.secondary, cs.onSecondary, widget.have.code),
              ],
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.only(top: 20),
          child: ButtonBar(
            children: [
              ElevatedButton.icon(
                  onPressed: tradable
                      ? () {
                          widget.create(widget.post.id);
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                      textStyle: t.textTheme.bodyMedium,
                      minimumSize: const Size(100, 48)),
                  icon: const Icon(Icons.swap_calls),
                  label: const Text("Trade")),
            ],
          ),
        )
      ],
    );

    return Card(
      child: Container(
        padding: const EdgeInsets.all(12),
        child: InkWell(
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Column(
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Text("What you have", style: overline)),
                  widget.lookingFor
                          .map((e) => e.id)
                          .toList()
                          .contains(widget.post.index?.id)
                      ? toChip(
                          cs.primary, cs.onPrimary, widget.post.index?.code)
                      : toChip(t.disabledColor, cs.onPrimary,
                          widget.post.index?.code),
                ],
              ),
              const Icon(Icons.arrow_forward),
              Column(
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Text("What you wanted", style: overline)),
                  Row(
                    children: [
                      ...?widget.post.lookingFor
                          ?.map((e) => widget.have.id == e.id
                              ? toChip(cs.primary, cs.onPrimary, e.code)
                              : toChip(t.disabledColor, cs.onPrimary, e.code))
                          .toList()
                    ],
                  ),
                ],
              )
            ]),
            const Divider(
              height: 24,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
            ExpandableIndex(
              inset: 0,
              title: "",
              indexes: [widget.post.index!, ...?widget.post.lookingFor],
            ),
            const Divider(
              height: 24,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
            opened ? expanded : collapsed
          ]),
        ),
      ),
    );
  }

  Widget toChip(Color c, Color tc, String? text) {
    return Chip(
        backgroundColor: c,
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        label: Text(
          text ?? "Unknown Index",
          style:
              TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: tc),
        ));
  }
}
