import 'package:coursecupid/core/api_service.dart';
import 'package:flutter/material.dart';

import '../api_lib/swagger.swagger.dart';
import '../auth/lib/user.dart';
import 'module_widget.dart';

class ModuleList extends StatelessWidget {
  final List<ModulePrincipalRes> modules; // data
  final ApiService api;
  final AuthMetaUser user;

  const ModuleList(this.modules, this.user, {Key? key, required this.api})
      : super(key: key); // setting the data

  @override
  Widget build(BuildContext context) {
    var children = modules
        .map((m) => ModuleWidget(
              module: m,
              api: api,
              user: user,
              modules: modules,
            ))
        .toList();
    return ListView(
      children: children,
    );
  }
}
