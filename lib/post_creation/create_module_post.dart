import 'package:coursecupid/core/resp_ext.dart';
import 'package:coursecupid/post_creation/create_post.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../api_lib/swagger.swagger.dart';
import '../components/error_renderer.dart';
import '../core/api_service.dart';
import '../http_error.dart';

class CreateModulePost extends StatefulWidget {
  final List<ModulePrincipalRes> modules;
  final ApiService api;
  final ModulePrincipalRes? initModule;
  final List<String>? initOffers;

  const CreateModulePost(
      {Key? key,
      required this.modules,
      required this.api,
      this.initModule,
      this.initOffers})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CreateModulePost();
}

class _CreateModulePost extends State<CreateModulePost> {
  ModulePrincipalRes? _selected;
  HttpResponseError? createErr;

  @override
  initState() {
    _selected = widget.initModule;
    super.initState();
  }

  Future<List<ModulePrincipalRes>> search(String? filter) {
    var f = filter ?? "";
    return Future.value(widget.modules
        .where((x) => f.lowerCompare(x.courseCode) || f.lowerCompare(x.name))
        .toList());
  }

  setError(HttpResponseError? err) {
    setState(() => createErr = err);
  }

  @override
  Widget build(BuildContext context) {
    var t = Theme.of(context);
    var cs = t.colorScheme;

    var errWidget = createErr == null
        ? const SizedBox(height: 20)
        : Container(
            padding: const EdgeInsets.all(24), child: ErrorDisplay(createErr!));
    var indexChoice = _selected == null
        ? const SizedBox(height: 20)
        : CreatePostLoader(
            offersInit: widget.initOffers,
            module: _selected!,
            api: widget.api,
            setErr: setError);
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
              popupItemBuilder:
                  (BuildContext context, ModulePrincipalRes? p, bool selected) {
                return ListTile(
                  leading: const Icon(Icons.description),
                  title: Text(
                    p?.courseCode ?? "Unknown Course Code",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(p?.name ?? "Unknown Course Name"),
                  trailing: Chip(
                    label: Text(
                      "${p?.academicUnit ?? -1} AU",
                      style: TextStyle(color: cs.onPrimary),
                    ),
                    backgroundColor: cs.secondary,
                  ),
                );
              },
              showSearchBox: true,
              showClearButton: true,
              mode: Mode.BOTTOM_SHEET,
              onFind: search,
              itemAsString: (ModulePrincipalRes? u) =>
                  "${u?.courseCode}: ${u?.name}",
              onChanged: (ModulePrincipalRes? data) {
                setState(() => _selected = null);
                setState(() => _selected = data);
              },
              selectedItem: _selected,
            ),
          ),
          indexChoice
        ]));
  }
}
