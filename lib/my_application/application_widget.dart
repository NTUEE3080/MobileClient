import 'package:coursecupid/auth/lib/user.dart';
import 'package:coursecupid/core/animation.dart';
import 'package:coursecupid/core/resp_ext.dart';
import 'package:coursecupid/my_application/contact_page.dart';
import 'package:coursecupid/my_application/index_row.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  String get status => app.principal?.status ?? "Unknown status";

  bool get isOwner =>
      app.post?.ownerId != null && app.post?.ownerId == user.data?.guid;

  bool get isApplier =>
      app.principal?.user?.id != null && app.post?.ownerId == user.data?.guid;

  List<IndexPrincipalRes> get offers => app.principal?.offers ?? [];

  Widget _buildCompleted(BuildContext context) {
    var t = Theme.of(context);
    var cs = t.colorScheme;
    var pIndex = app.post?.index;
    var postIndexes = (pIndex == null ? <IndexPrincipalRes>[] : [pIndex]);
    var offerIndexes = [...?app.principal?.offers];
    List<IndexPrincipalRes> yours = isOwner ? postIndexes : offerIndexes;
    List<IndexPrincipalRes> theirs = isOwner ? offerIndexes : postIndexes;
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
              ExpandableIndex(
                title: "Yours",
                indexes: yours,
              ),
              ExpandableIndex(
                title: "Traded",
                indexes: theirs,
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
                leading: app.principal?.status == "pending"
                    ? const Icon(Icons.pending)
                    : const Icon(Icons.close),
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
              ...?app.post?.index?.props
                  ?.map((e) => IndexRowView(prop: e))
                  .toList(),
              const Divider(
                height: 12,
                thickness: 1,
                indent: 0,
                endIndent: 0,
              ),
              ListTile(
                title: Text(
                  "Offers",
                  style: t.textTheme.overline,
                ),
                subtitle: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: offers
                        .map((e) => Chip(
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
                            )))
                        .toList(),
                  ),
                ),
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
              ExpandableIndex(
                title: "Offers",
                indexes: offers,
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
}

class _ApplicationWidgetState extends State<ApplicationWidget> {
  bool isBusy = false;

  busy() => setState(() => isBusy = true);

  free() => setState(() => isBusy = false);

  _accept() async {
    busy();
    var r = await widget.api.access.postAcceptPostIdAppIdPost(
        postId: widget.app.post?.id, appId: widget.app.principal?.id);
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
        postId: widget.app.post?.id, appId: widget.app.principal?.id);
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
        : (widget.isOwner
            ? widget._buildOwner(context, _accept, _reject)
            : widget._buildApplier(context));
    return isBusy ? lAnim : content;
  }
}
