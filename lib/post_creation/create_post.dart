import 'package:coursecupid/core/api_service.dart';
import 'package:coursecupid/core/resp_ext.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../api_lib/swagger.swagger.dart';
import '../core/animation.dart';
import '../core/result_ext.dart';
import '../http_error.dart';
import '../my_application/index_row.dart';

Widget indexBuilder(BuildContext context, IndexRes? p, bool selected) {
  var t = Theme.of(context);
  var cs = t.colorScheme;
  return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: Text(
            p?.principal?.code ?? "Unknown Index Code",
            style: t.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: cs.secondary,
            ),
          ),
        ),
        ...?p?.principal?.props?.map((e) => IndexRowView(prop: e)),
        const Divider(
          height: 12,
          thickness: 1,
          indent: 0,
          endIndent: 0,
        )
      ]);
}

class CreatePostLoader extends StatelessWidget {
  final ModulePrincipalRes module;
  final ApiService api;
  final List<String>? offersInit;
  final void Function(HttpResponseError? e) setErr;

  const CreatePostLoader(
      {Key? key,
      required this.module,
      required this.api,
      required this.setErr,
      this.offersInit})
      : super(key: key);

  Future<Result<List<IndexRes>, HttpResponseError>> getIndexList() async {
    return (await api.access.indexGet(
      semester: module.semester,
      course: module.id,
    ))
        .toResult();
  }

  @override
  Widget build(BuildContext context) {
    var errorAnimPage = const AnimationFrame(
        asset: LottieAnimations.laptop,
        text: "Error - Cannot obtain index list");
    var loading = const AnimationFrame(
        asset: LottieAnimations.loading, text: "Loading Indexes...");
    return FutureBuilder<Result<List<IndexRes>, HttpResponseError>>(
        future: getIndexList(),
        builder: (context, val) {
          if (val.connectionState == ConnectionState.done) {
            if (val.hasData) {
              var v = val.data!;
              if (v.isSuccess) {
                return CreatePost(
                  indexInit: offersInit,
                  indexes: v.value,
                  module: module,
                  api: api,
                  setErr: setErr,
                );
              }
            }
            return errorAnimPage;
          } else {
            return loading;
          }
        });
  }
}

class CreatePost extends StatefulWidget {
  final ModulePrincipalRes module;
  final List<IndexRes> indexes;
  final List<String>? indexInit;
  final ApiService api;
  final void Function(HttpResponseError? e) setErr;

  const CreatePost(
      {Key? key,
      required this.module,
      required this.indexes,
      required this.api,
      required this.setErr,
      this.indexInit})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  Future<List<IndexRes>> search(String? filter) {
    var f = filter ?? "";
    return Future.value(widget.indexes
        .where((e) =>
            f.lowerCompare(e.principal?.code) ||
            (e.principal?.props
                    ?.any((element) => f.lowerCompare(element.day)) ??
                false))
        .toList());
  }

  Future<List<IndexRes>> searchWithoutOffers(String? filter) {
    var f = filter ?? "";
    var offerIds = offers.map((e) => e.principal?.id ?? "non-id");
    return Future.value(widget.indexes
        .where((e) =>
            f.lowerCompare(e.principal?.code) ||
            (e.principal?.props
                    ?.any((element) => f.lowerCompare(element.day)) ??
                false))
        .where((e) => !offerIds.contains(e.principal?.id))
        .toList());
  }

  List<IndexRes> offers = [];
  IndexRes? _wantSelected;
  IndexRes? _haveSelected;
  bool loading = false;

  @override
  initState() {
    var cond = widget.indexInit?.every((s) =>
            widget.indexes.where((x) => x.principal?.id == s).isNotEmpty) ??
        false;
    if (cond) {
      var offerInit = widget.indexInit
          ?.map((x) => widget.indexes
              .firstWhere((e) => (e.principal?.id ?? "non-id") == x))
          .toList();
      offers = [...?offerInit];
    }

    super.initState();
  }

  busy() => setState(() => loading = true);

  free() => setState(() => loading = false);

  _removeOffer(String id) {
    var removed =
        offers.where((element) => element.principal?.id != id).toList();
    setState(() => offers = removed);
  }

  _create(context) async {
    if (_haveSelected == null || offers.isEmpty) return;
    busy();
    var r = await widget.api.access.postPost(
        body: CreatePostReq(
            modulesId: widget.module.id,
            indexId: _haveSelected!.principal!.id,
            lookingForId: offers.map((e) => e.principal!.id!).toList()));
    var result = r.toResult();
    if (result.isSuccess) {
      widget.setErr(null);
      free();
      Navigator.pop(context);
    } else {
      widget.setErr(result.error);
      free();
    }
  }

  @override
  Widget build(BuildContext context) {
    var widget = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          child: DropdownSearch<IndexRes>(
            popupItemBuilder: indexBuilder,
            dropdownSearchDecoration:
                const InputDecoration(labelText: 'Index You Have'),
            showSearchBox: true,
            showClearButton: true,
            mode: Mode.BOTTOM_SHEET,
            onFind: search,
            itemAsString: (IndexRes? u) => u?.principal?.code ?? "",
            onChanged: (IndexRes? data) {
              setState(() => _haveSelected = data);
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: DropdownSearch<IndexRes>(
                  dropdownSearchDecoration:
                      const InputDecoration(labelText: 'Index You Want'),
                  popupItemBuilder: indexBuilder,
                  showSearchBox: true,
                  showClearButton: true,
                  mode: Mode.BOTTOM_SHEET,
                  onFind: searchWithoutOffers,
                  itemAsString: (IndexRes? u) => u?.principal?.code ?? "",
                  onChanged: (IndexRes? data) {
                    setState(() => _wantSelected = data);
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
                    if (_wantSelected != null &&
                        !offers.contains(_wantSelected)) {
                      setState(() {
                        offers = [...offers, _wantSelected!];
                      });
                    }
                    setState(() {
                      _wantSelected = null;
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
                        backgroundColor: Theme.of(context).colorScheme.primary,
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
              onPressed: _haveSelected != null &&
                      offers.isNotEmpty &&
                      !offers.contains(_haveSelected)
                  ? () => _create(context)
                  : null,
              child: const Text("create"),
              style: ElevatedButton.styleFrom(
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(9.0)),
                minimumSize: const Size(120, 56),
              ),
            ),
          ],
        )
      ],
    );
    var loadAnim = const AnimationFrame(
        asset: LottieAnimations.register, text: "Creating post...");
    return loading ? loadAnim : widget;
  }
}
