import 'package:coursecupid/core/resp_ext.dart';
import 'package:coursecupid/post_application/post_application_load.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../api_lib/swagger.swagger.dart';
import '../components/error_renderer.dart';
import '../core/animation.dart';
import '../core/api_service.dart';
import '../http_error.dart';

class CreateApplicationPage extends StatefulWidget {
  final ApplicationViewModel vm;
  final ApiService api;

  const CreateApplicationPage({Key? key, required this.vm, required this.api})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CreateModulePost();
}

class _CreateModulePost extends State<CreateApplicationPage> {
  IndexRes? _selected;
  HttpResponseError? createErr;
  List<IndexRes> offers = [];
  bool isLoading = false;

  busy() => setState(() => isLoading = true);

  free() => setState(() => isLoading = false);

  _create(context) async {
    if (offers.isEmpty) return;
    busy();
    var r = await widget.api.access.applicationPostIdPost(
        postId: widget.vm.post.post?.id ?? "",
        body: CreateApplicationReq(
          offerId: offers.map((e) => e.principal!.id!).toList(),
        ));
    var result = r.toResult();
    if (result.isSuccess) {
      setError(null);
      free();
      Navigator.pop(context);
    } else {
      setError(result.error);
      free();
    }
  }

  setError(HttpResponseError? err) {
    setState(() => createErr = err);
  }

  _removeOffer(String id) {
    var removed =
        offers.where((element) => element.principal?.id != id).toList();
    setState(() => offers = removed);
  }

  Future<List<IndexRes>> _search(String? filter) {
    var f = filter ?? "";
    var offerIds = offers.map((e) => e.principal?.id ?? "non-id");
    return Future.value(widget.vm.indexes
        .where((e) => f.lowerCompare(e.principal?.code))
        .where((e) => !offerIds.contains(e.principal?.id))
        .toList());
  }

  @override
  Widget build(BuildContext context) {
    var errWidget = createErr == null
        ? const SizedBox(height: 20)
        : Container(
            padding: const EdgeInsets.all(24), child: ErrorDisplay(createErr!));
    var loadAnim = const AnimationPage(
        asset: LottieAnimations.register, text: "Applying...");
    var page = Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back),
          ),
          title: Text("Apply to ${widget.vm.post.post?.index?.code ?? ''}"),
        ),
        body: Column(children: [
          // TODO: insert index details here
          errWidget,
          Container(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: DropdownSearch<IndexRes>(
                    dropdownSearchDecoration:
                        const InputDecoration(labelText: 'Offers'),
                    showSearchBox: true,
                    showClearButton: true,
                    mode: Mode.BOTTOM_SHEET,
                    onFind: _search,
                    itemAsString: (IndexRes? u) => u?.principal?.code ?? "",
                    onChanged: (IndexRes? data) {
                      setState(() => _selected = data);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Ink(
                  decoration: ShapeDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: const CircleBorder(),
                  ),
                  child: IconButton(
                    onPressed: () {
                      if (_selected != null && !offers.contains(_selected)) {
                        setState(() {
                          offers = [...offers, _selected!];
                        });
                      }
                      setState(() {
                        _selected = null;
                      });
                    },
                    icon: const Icon(Icons.add),
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(24),
            child: Wrap(
              alignment: WrapAlignment.spaceAround,
              spacing: 24,
              runSpacing: 8,
              children: offers
                  .map((x) => InkWell(
                      onTap: () => _removeOffer(x.principal?.id ?? "non-id"),
                      child: Chip(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          padding: const EdgeInsets.all(12),
                          label: Text(
                            x.principal?.code ?? "",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary),
                          ))))
                  .toList(),
            ),
          ),
          const SizedBox(height: 40),
          ButtonBar(
            buttonHeight: 100,
            children: [
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("back"),
                style: ElevatedButton.styleFrom(
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(9.0)),
                  minimumSize: const Size(120, 56),
                  elevation: 0,
                ),
              ),
              ElevatedButton(
                onPressed: offers.isNotEmpty ? () => _create(context) : null,
                child: const Text("apply"),
                style: ElevatedButton.styleFrom(
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(9.0)),
                  minimumSize: const Size(120, 56),
                ),
              ),
            ],
          )
        ]));
    return isLoading ? loadAnim : page;
  }
}
