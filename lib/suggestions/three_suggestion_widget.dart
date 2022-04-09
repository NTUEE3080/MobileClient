import 'package:coursecupid/auth/lib/user.dart';
import 'package:flutter/material.dart';

import '../api_lib/swagger.swagger.dart';
import '../core/api_service.dart';
import '../my_application/expandable_indexes.dart';

class ThreeWaySuggestionWidget extends StatefulWidget {
  final ThreeWaySuggestionResp suggestion; // data/state
  final ApiService api;
  final AuthMetaUser user;
  final Future<void> Function() refresh;

  const ThreeWaySuggestionWidget(
      {Key? key,
      required this.api,
      required this.user,
      required this.refresh,
      required this.suggestion})
      : super(key: key); // sets the state on construction

  String get courseCode => suggestion.module ?? "Unknown module";

  String get courseName => suggestion.post1?.module?.name ?? "Unknown module";

  int get au => suggestion.post1?.module?.academicUnit ?? -1;

  PostPrincipalResp get index1 => suggestion.post1?.owner?.id == user.data?.guid
      ? suggestion.post1!
      : (suggestion.post2?.owner?.id == user.data?.guid
          ? suggestion.post2!
          : suggestion.post3!);

  PostPrincipalResp get index2 => suggestion.post1?.owner?.id == user.data?.guid
      ? suggestion.post2!
      : (suggestion.post2?.owner?.id == user.data?.guid
          ? suggestion.post3!
          : suggestion.post1!);

  PostPrincipalResp get index3 => suggestion.post1?.owner?.id == user.data?.guid
      ? suggestion.post3!
      : (suggestion.post2?.owner?.id == user.data?.guid
          ? suggestion.post1!
          : suggestion.post2!);

  Widget _buildApplier(BuildContext context) {
    var t = Theme.of(context);
    var cs = t.colorScheme;
    var overline = t.textTheme.overline;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Card(
        elevation: 6,
        child: InkWell(
          onTap: () {},
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Row(
                  children: [
                    Text("$courseCode ",
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                subtitle: Text(courseName),
                trailing: Chip(
                  label: Text(
                    "$au AU",
                    style: TextStyle(color: cs.onPrimary),
                  ),
                  backgroundColor: cs.secondary,
                ),
              ),
              const Divider(
                height: 12,
                thickness: 1,
                indent: 0,
                endIndent: 0,
              ),
              Container(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text("Suggested Trade Details",
                      style: t.textTheme.titleLarge)),
              Container(
                padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Text("Intermediate Trade",
                                    style: overline)),
                            toChip(cs.primary, cs.onPrimary, index2.index?.code)
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Icon(Icons.north_east),
                        Icon(Icons.south_east),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Text("You can offer", style: overline)),
                            toChip(cs.primary, cs.onPrimary, index1.index?.code)
                          ],
                        ),
                        const Icon(Icons.arrow_back),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Text("To get their", style: overline)),
                            toChip(cs.primary, cs.onPrimary, index3.index?.code)
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 12,
                thickness: 1,
                indent: 0,
                endIndent: 0,
              ),
              ExpandableIndex(
                title: "Index Information",
                indexes: [index1.index!, index2.index!, index3.index!],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget toChip(Color c, Color tc, String? text) {
    return Chip(
        backgroundColor: c,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
        label: Text(
          text ?? "Unknown",
          style:
              TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: tc),
        ));
  }

  @override
  State<StatefulWidget> createState() => _ThreeWaySuggestionWidgetState();
}

class _ThreeWaySuggestionWidgetState extends State<ThreeWaySuggestionWidget> {
  @override
  Widget build(BuildContext context) {
    return widget._buildApplier(context);
  }
}
