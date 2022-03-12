import 'package:coursecupid/auth/lib/user.dart';
import 'package:coursecupid/index/index.dart';
import 'package:flutter/material.dart';
import 'package:json_theme/json_theme_schemas.dart';

import '../api_lib/swagger.swagger.dart';
import '../core/api_service.dart';

class ModuleWidget extends StatelessWidget {
  final ModulePrincipalRes module; // data/state
  final ApiService api;
  final AuthMetaUser user;

  const ModuleWidget(
      {Key? key, required this.module, required this.api, required this.user})
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
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (ctx) => PostLoader(
                          user: user,
                          api: api,
                          module: module,
                        )));
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.description),
                title: Text(
                  module.courseCode!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: cs.secondary,
                  ),
                ),
                subtitle: Text(module.name!),
                trailing: Chip(
                  label: Text(
                    "${module.academicUnit} AU",
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
                padding: const EdgeInsets.all(24),
                child: Text(
                  module.description ?? "unknown description",
                  style: t.textTheme.bodyLarge,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
