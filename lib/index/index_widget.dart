import 'package:coursecupid/auth/lib/user.dart';
import 'package:coursecupid/index/post_view_model.dart';
import 'package:coursecupid/post_application/post_application_load.dart';
import 'package:flutter/material.dart';

import '../api_lib/swagger.swagger.dart';
import '../core/api_service.dart';
import '../my_application/index_row.dart';

class IndexWidget extends StatelessWidget {
  final PostViewModel post; // data/state
  final ApiService api;
  final Future<void> Function() refresh;
  final AuthMetaUser user;
  final List<ModulePrincipalRes> modules;

  const IndexWidget(
      {Key? key,
      required this.post,
      required this.api,
      required this.refresh,
      required this.user,
      required this.modules})
      : super(key: key); // sets the state on construction

  @override
  Widget build(BuildContext context) {
    var t = Theme.of(context);
    var cs = t.colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Card(
        elevation: 2,
        child: InkWell(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.description),
                title: Text(
                  post.index.code!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: cs.secondary,
                  ),
                ),
              ),
              ...?post.index.props?.map((e) => IndexRowView(prop: e)),
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
                    children: post.lookingFor
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
              const Divider(
                height: 12,
                thickness: 1,
                indent: 0,
                endIndent: 0,
              ),
              ButtonBar(
                children: <Widget>[
                  ElevatedButton(
                    child: const Text('Apply'),
                    onPressed: post.self
                        ? null
                        : () {
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => PostApplicationLoader(
                                              modules: modules,
                                              user: user,
                                              api: api,
                                              postId: post.id,
                                            )))
                          .then((value) async => await refresh());
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
