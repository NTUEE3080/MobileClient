import 'package:coursecupid/auth/lib/user.dart';
import 'package:coursecupid/core/animation.dart';
import 'package:coursecupid/core/resp_ext.dart';
import 'package:coursecupid/my_application/contact_page.dart';
import 'package:flutter/material.dart';

import '../api_lib/swagger.swagger.dart';
import '../auth/frame.dart';
import '../core/api_service.dart';
import 'expandable_indexes.dart';

class ApplicationWidget extends StatefulWidget {
  final ApplicationRes app; // data/state
  final ApiService api;
  final AuthMetaUser user;
  final Future<void> Function() refresh;

  const ApplicationWidget(
      {Key? key,
      required this.app,
      required this.api,
      required this.user,
      required this.refresh})
      : super(key: key); // sets the state on construction

  String get courseCode => app.post?.module?.courseCode ?? "Unknown module";

  String get courseName => app.post?.module?.name ?? "Unknown module";

  String get index => app.post?.index?.code ?? "Unknown index";

  int get au => app.post?.module?.academicUnit ?? -1;

  String get status => app.status ?? "Unknown status";

  bool get isOwner =>
      app.post?.owner?.id != null && app.post?.owner?.id == user.data?.guid;

  bool get isApplier =>
      app.applied?.owner?.id != null &&
      app.applied?.owner?.id == user.data?.guid;

  Widget _buildCompleted(BuildContext context) {
    var t = Theme.of(context);
    var cs = t.colorScheme;
    var pIndex = app.post?.index;
    var oIndex = app.applied?.index;
    var postIndexes = (pIndex == null ? <IndexPrincipalRes>[] : [pIndex]);
    var offerIndexes = (oIndex == null ? <IndexPrincipalRes>[] : [oIndex]);
    List<IndexPrincipalRes> yours = isOwner ? postIndexes : offerIndexes;
    List<IndexPrincipalRes> theirs = isOwner ? offerIndexes : postIndexes;
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
                    Text(index, style: TextStyle(color: cs.secondary)),
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
                  child: Text("Trade Details", style: t.textTheme.titleLarge)),
              Container(
                padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text("Your traded", style: overline)),
                        toChip(cs.primary, cs.onPrimary, yours[0].code)
                      ],
                    ),
                    const Icon(Icons.arrow_forward),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text("To get", style: overline)),
                        toChip(cs.primary, cs.onPrimary, theirs[0].code)
                      ],
                    )
                  ],
                ),
              ),
              const Divider(
                height: 12,
                thickness: 1,
                indent: 0,
                endIndent: 0,
              ),
              ButtonBar(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ContactPage(
                                      app: app, api: api, user: user)))
                          .then((value) async => await refresh());
                    },
                    icon: Icon(Icons.phone, color: cs.onPrimary),
                    label: Text("Contact",
                        style: TextStyle(
                          color: cs.onPrimary,
                        )),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 56),
                      elevation: 0,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildApplier(BuildContext context) {
    var t = Theme.of(context);
    var cs = t.colorScheme;
    var overline = t.textTheme.overline;
    var yours = app.applied?.index;
    var theirs = app.post?.index;
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
                    Text(index, style: TextStyle(color: cs.secondary)),
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
                  child: Text("Trade Details", style: t.textTheme.titleLarge)),
              Container(
                padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text("You offered", style: overline)),
                        toChip(cs.primary, cs.onPrimary, yours?.code)
                      ],
                    ),
                    const Icon(Icons.arrow_forward),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text("To get their", style: overline)),
                        toChip(cs.primary, cs.onPrimary, theirs?.code)
                      ],
                    )
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
                indexes: app.applied?.index == null
                    ? <IndexPrincipalRes>[]
                    : [app.applied!.index!, app.post!.index!],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRejected(BuildContext context) {
    var t = Theme.of(context);
    var cs = t.colorScheme;
    var overline = t.textTheme.overline;
    var yours = app.applied?.index;
    var theirs = app.post?.index;
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
                    Text(index, style: TextStyle(color: cs.secondary)),
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
                  child: Text("Trade Details", style: t.textTheme.titleLarge)),
              Container(
                padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text("They rejected your", style: overline)),
                        toChip(cs.primary, cs.onPrimary, yours?.code)
                      ],
                    ),
                    const Icon(Icons.arrow_forward),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text("for their", style: overline)),
                        toChip(cs.primary, cs.onPrimary, theirs?.code)
                      ],
                    )
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
                indexes: app.applied?.index == null
                    ? <IndexPrincipalRes>[]
                    : [app.applied!.index!, app.post!.index!],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOwner(
      BuildContext context, VoidCallback accept, VoidCallback reject) {
    var t = Theme.of(context);
    var cs = t.colorScheme;
    var yours = app.post?.index;
    var theirs = app.applied?.index;

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
                    Text(index),
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
                  child: Text("Trade Details", style: t.textTheme.titleLarge)),
              Container(
                padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text("They are offering", style: overline)),
                        toChip(cs.primary, cs.onPrimary, theirs?.code)
                      ],
                    ),
                    const Icon(Icons.arrow_forward),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text("To get your", style: overline)),
                        toChip(cs.primary, cs.onPrimary, yours?.code)
                      ],
                    )
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
                indexes: app.applied?.index == null
                    ? <IndexPrincipalRes>[]
                    : [app.applied!.index!, app.post!.index!],
              ),
              const Divider(
                height: 12,
                thickness: 1,
                indent: 0,
                endIndent: 0,
              ),
              ButtonBar(
                children: [
                  OutlinedButton.icon(
                      onPressed: reject,
                      icon: const Icon(Icons.close),
                      label: const Text("Reject"),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(100, 56),
                        primary: cs.error,
                      )),
                  ElevatedButton.icon(
                    onPressed: accept,
                    icon: Icon(Icons.check, color: cs.onPrimary),
                    label: Text("Accept",
                        style: TextStyle(
                          color: cs.onPrimary,
                        )),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 56),
                      elevation: 0,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => _ApplicationWidgetState();

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
}

class _ApplicationWidgetState extends State<ApplicationWidget> {
  bool isBusy = false;

  busy() => setState(() => isBusy = true);

  free() => setState(() => isBusy = false);

  _accept() async {
    busy();
    var r = await widget.api.access.postAcceptPostIdAppIdPost(
        postId: widget.app.post?.id, appId: widget.app.applied?.id);
    var result = r.toResult();
    if (result.isSuccess) {
      final snackBar = SnackBar(
        content: const Text('Accepted'),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      free();
      await widget.refresh();
    } else {
      final snackBar = SnackBar(
        content: const Text('Failed due to unknown reasons'),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      logger.e(result.error);
      free();
      await widget.refresh();
    }
  }

  _reject() async {
    busy();
    var r = await widget.api.access.postRejectPostIdAppIdPost(
        postId: widget.app.post?.id, appId: widget.app.applied?.id);
    var result = r.toResult();
    if (result.isSuccess) {
      final snackBar = SnackBar(
        content: const Text('Rejected'),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      free();
      await widget.refresh();
    } else {
      final snackBar = SnackBar(
        content: const Text('Rejected'),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      logger.e(result.error);
      free();
      await widget.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    var lAnim = const AnimationFrame(
        asset: LottieAnimations.loading, text: "Loading..");
    var content = widget.status == "accepted"
        ? widget._buildCompleted(context)
        : (widget.status == "rejected"
            ? widget._buildRejected(context)
            : (widget.isOwner
                ? widget._buildOwner(context, _accept, _reject)
                : widget._buildApplier(context)));
    return isBusy ? lAnim : content;
  }
}
