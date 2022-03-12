import 'package:coursecupid/index/post_view_model.dart';
import 'package:coursecupid/post_application/post_application_load.dart';
import 'package:flutter/material.dart';

import '../core/api_service.dart';

class IndexWidget extends StatelessWidget {
  final PostViewModel post; // data/state
  final ApiService api;
  final Future<void> Function() refresh;

  const IndexWidget(
      {Key? key, required this.post, required this.api, required this.refresh})
      : super(key: key); // sets the state on construction

  @override
  Widget build(BuildContext context) {
    // build method convert data into visuals
    var chips = post.lookingFor
        .map((p) => Chip(
              padding: const EdgeInsets.all(2),
              backgroundColor: Theme.of(context).colorScheme.primary,
              label: Text(p.code!,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary)),
            ))
        .toList();

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: post.applied
                ? const Icon(Icons.check)
                : const Icon(Icons.description),
            title: Text(post.index.code!),
            subtitle: Wrap(
              spacing: 24,
              children: chips,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                child: const Text('Apply'),
                onPressed: (post.applied || post.self)
                    ? null
                    : () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => PostApplicationLoader(
                                      api: api,
                                      postId: post.id,
                                    ))).then((value) async => await refresh());
                      },
              )
            ],
          ),
        ],
      ),
    );
  }
}
