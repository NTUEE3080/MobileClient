import 'package:coursecupid/auth/lib/user.dart';
import 'package:coursecupid/core/resp_ext.dart';
import 'package:flutter/material.dart';

import '../api_lib/swagger.swagger.dart';
import '../core/api_service.dart';
import 'modules.dart';

class ModulesPage extends StatefulWidget {
  const ModulesPage(
      {Key? key,
      required this.logout,
      required this.moduleList,
      required this.controller,
      required this.api,
      required this.user})
      : super(key: key);
  final VoidCallback logout;
  final List<ModulePrincipalRes> moduleList;
  final ApiService api;
  final AuthMetaUser user;
  final TextEditingController controller;

  @override
  State<StatefulWidget> createState() => _ModuleState();
}

class _ModuleState extends State<ModulesPage> {
  List<ModulePrincipalRes> fullList = [];
  List<ModulePrincipalRes> filteredList = [];
  String _searchTerm = "";

  _searchListener() {
    if (widget.controller.text.isEmpty) {
      setState(() {
        _searchTerm = "";
        filteredList = List.from(fullList);
      });
    } else {
      setState(() {
        _searchTerm = widget.controller.text;
        var lower = _searchTerm.toLowerCase();
        filteredList = fullList
            .where((x) =>
                _searchTerm.lowerCompare(x.courseCode) ||
                _searchTerm.lowerCompare(x.name))
            .toList();
      });
    }
  }

  @override
  void initState() {
    fullList = widget.moduleList;
    filteredList = fullList;
    widget.controller.addListener(_searchListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModuleList(filteredList, widget.user, api: widget.api);
  }
}
