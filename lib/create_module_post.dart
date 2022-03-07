import 'package:coursecupid/create_post.dart';
import 'package:coursecupid/swagger_generated_code/swagger.swagger.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'components/error_renderer.dart';
import 'core/api_service.dart';
import 'http_error.dart';

class CreateModulePost extends StatefulWidget {
  final List<ModulePrincipalRes> modules;
  final ApiService api;

  const CreateModulePost({Key? key, required this.modules, required this.api})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CreateModulePost();
}

class _CreateModulePost extends State<CreateModulePost> {
  ModulePrincipalRes? _selected;
  HttpResponseError? createErr;

  Future<List<ModulePrincipalRes>> search(String? filter) {
    var lower = filter?.toLowerCase() ?? "";
    return Future.value(widget.modules
        .where((x) =>
            x.courseCode!.toLowerCase().contains(lower) ||
            lower.contains(x.courseCode!.toLowerCase()) ||
            x.name!.toLowerCase().contains(lower) ||
            lower.contains(x.name!.toLowerCase()))
        .toList());
  }

  setError(HttpResponseError? err) {
    setState(() => createErr = err);
  }

  @override
  Widget build(BuildContext context) {
    var errWidget = createErr == null
        ? const SizedBox(height: 20)
        : ErrorDisplay(createErr!);
    var indexChoice = _selected == null
        ? const SizedBox(height: 20)
        : CreatePostLoader(
            module: _selected!, api: widget.api, setErr: setError);
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back),
          ),
          title: const Text("Create Post"),
        ),
        body: Column(children: [
          errWidget,
          Container(
            padding: const EdgeInsets.all(12),
            child: DropdownSearch<ModulePrincipalRes>(
              dropdownSearchDecoration:
                  const InputDecoration(labelText: 'Module'),
              showSearchBox: true,
              showClearButton: true,
              mode: Mode.BOTTOM_SHEET,
              onFind: search,
              itemAsString: (ModulePrincipalRes? u) =>
                  "${u?.courseCode}: ${u?.name}",
              onChanged: (ModulePrincipalRes? data) {
                setState(() => _selected = data);
              },
            ),
          ),
          indexChoice
        ]));
  }
}
