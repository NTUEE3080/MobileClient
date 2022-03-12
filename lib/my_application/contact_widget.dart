import 'package:coursecupid/api_lib/swagger.swagger.dart';
import 'package:flutter/material.dart';
import 'package:coursecupid/auth/lib/user.dart';
import 'package:url_launcher/url_launcher.dart';

import 'expandable_indexes.dart';

String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}

class ContactWidget extends StatelessWidget {
  final ApplicationRes app;
  final UserPrincipalResp postUser;
  final AuthMetaUser user;

  String get courseCode => app.post?.module?.courseCode ?? "Unknown module";

  String get courseName => app.post?.module?.name ?? "Unknown module";

  bool get isOwner =>
      app.post?.ownerId != null && app.post?.ownerId == user.data?.guid;

  bool get isApplier =>
      app.principal?.user?.id != null && app.post?.ownerId == user.data?.guid;

  const ContactWidget(
      {Key? key, required this.app, required this.user, required this.postUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var t = Theme.of(context);
    var cs = t.colorScheme;
    var pIndex = app.post?.index;
    var postIndexes = (pIndex == null ? <IndexPrincipalRes>[] : [pIndex]);
    var offerIndexes = [...?app.principal?.offers];
    List<IndexPrincipalRes> yours = isOwner ? postIndexes : offerIndexes;
    List<IndexPrincipalRes> theirs = isOwner ? offerIndexes : postIndexes;
    var email = isOwner
        ? app.principal?.user?.email ?? "unknown email"
        : postUser.email ?? "unknown email";
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back),
          ),
          title: Text("Contact - $courseCode"),
        ),
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
              child: Card(
                elevation: 2,
                child: InkWell(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const ListTile(
                        title: Text("Your Index(es)",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      ExpandableIndex(
                        indexes: yours,
                      ),
                    ],
                  ),
                  onTap: () {},
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Card(
                elevation: 2,
                child: InkWell(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const ListTile(
                        title: Text("Traded Index(es)",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      ExpandableIndex(
                        indexes: theirs,
                      ),
                    ],
                  ),
                  onTap: () {},
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
              child: Card(
                elevation: 2,
                child: InkWell(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.email),
                        title: const Text("Contact",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(email, style: t.textTheme.overline),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            child: const Text('Send Email'),
                            onPressed: () {
                              final Uri emailLaunchUri = Uri(
                                scheme: 'mailto',
                                path: email,
                                query: encodeQueryParameters(<String, String>{
                                  'subject':
                                      'Example Subject & Symbols are allowed!'
                                }),
                              );
                              launch(emailLaunchUri.toString());
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                  onTap: () {},
                ),
              ),
            ),
          ],
        ));
  }
}
