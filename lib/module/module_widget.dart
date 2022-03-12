import 'package:coursecupid/auth/lib/user.dart';
import 'package:coursecupid/index/index.dart';
import 'package:flutter/material.dart';

import '../api_lib/swagger.swagger.dart';
import '../core/api_service.dart';

class ModuleWidget extends StatelessWidget {
  final ModulePrincipalRes module; // data/state
  final ApiService api;
  final AuthMetaUser user;

  const ModuleWidget({Key? key, required this.module, required this.api, required this.user})
      : super(key: key); // sets the state on construction

  @override
  Widget build(BuildContext context) {
    // build method convert data into visuals
    return GestureDetector(
      // what action to perform when child is tapped
      onTap: () {
        // opening new page
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => PostLoader(
                  user: user,
                  api: api,
                  module: module,
                )));
      },
      // displaying the data
      // child: Text(module.code));
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.description),
              title: Text(module.name!),
              subtitle: Text(module.description!),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: Text('Module Code: ${module.courseCode!}'),
                  onPressed: () {
                    /* ... */
                  },
                ),
                const SizedBox(width: 10),
                TextButton(
                  child: Text('Course AU: ${module.academicUnit!}'),
                  onPressed: () {
                    /* ... */
                  },
                ),
                const SizedBox(width: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}