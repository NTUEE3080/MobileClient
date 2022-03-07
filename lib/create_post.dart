import 'package:coursecupid/core/api_service.dart';
import 'package:coursecupid/core/resp_ext.dart';
import 'package:coursecupid/swagger_generated_code/swagger.swagger.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'core/animation.dart';
import 'core/result_ext.dart';
import 'http_error.dart';

class CreatePostLoader extends StatelessWidget {
  final ModulePrincipalRes module;
  final ApiService api;
  final void Function(HttpResponseError? e) setErr;

  const CreatePostLoader(
      {Key? key, required this.module, required this.api, required this.setErr})
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
    var errorAnimPage = const AnimationPage(
        asset: LottieAnimations.laptop,
        text: "Error - Cannot obtain index list");
    var loading = const AnimationPage(
        asset: LottieAnimations.loading, text: "Loading Indexes...");
    return FutureBuilder<Result<List<IndexRes>, HttpResponseError>>(
        future: getIndexList(),
        builder: (context, val) {
          if (val.hasData) {
            var v = val.data!;
            if (v.isSuccess) {
              return CreatePost(
                indexes: v.value,
                module: module,
                api: api,
                setErr: setErr,
              );
            } else {
              return errorAnimPage;
            }
          }
          return loading;
        });
  }
}

class CreatePost extends StatefulWidget {
  final ModulePrincipalRes module;
  final List<IndexRes> indexes;
  final ApiService api;
  final void Function(HttpResponseError? e) setErr;

  const CreatePost(
      {Key? key,
      required this.module,
      required this.indexes,
      required this.api,
      required this.setErr})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  Future<List<IndexRes>> search(String? filter) {
    var lower = filter?.toLowerCase() ?? "";
    return Future.value(widget.indexes
        .where((e) =>
            e.principal!.code!.toLowerCase().contains(lower) ||
            lower.contains(e.principal!.code!.toLowerCase()))
        .toList());
  }

  Future<List<IndexRes>> searchWithoutOffers(String? filter) {
    var lower = filter?.toLowerCase() ?? "";
    var offerIds = offers.map((e) => e.principal?.id ?? "non-id");
    return Future.value(widget.indexes
        .where((e) =>
            e.principal!.code!.toLowerCase().contains(lower) ||
            lower.contains(e.principal!.code!.toLowerCase()))
        .where((e) => !offerIds.contains(e.principal?.id))
        .toList());
  }

  List<IndexRes> offers = [];
  IndexRes? _wantSelected;
  IndexRes? _haveSelected;
  bool loading = false;

  busy() => setState(() => loading = true);

  free() => setState(() => loading = false);

  _removeOffer(String id) {
    var removed =
        offers.where((element) => element.principal?.id != id).toList();
    setState(() => offers = removed);
  }

  _create(context) async {
    logger.i("called");
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
            // dropdownBuilder: (context, selectedItem) {
            //   return ListTile(
            //     title: Text(selectedItem?.principal?.code ?? ""),
            //     subtitle: Column(
            //       children: selectedItem?.principal?.props
            //               ?.map((e) => Row(
            //                     children: [
            //                       Chip(label: Text(e.type!)),
            //                       Chip(label: Text(e.day!)),
            //                       Chip(
            //                           label:
            //                               Text("${e.start!} - ${e.stop!}")),
            //                       Chip(label: Text(e.venue!)),
            //                     ],
            //                   ))
            //               ?.toList() ??
            //           [],
            //     ),
            //   );
            // },
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
        const SizedBox(height: 80),
        Text("Your offers", style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 28),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: offers
              .map((x) => InkWell(
                  onTap: () => _removeOffer(x.principal?.id ?? "non-id"),
                  child: Chip(label: Text(x.principal?.code ?? ""))))
              .toList(),
        ),
        Container(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: DropdownSearch<IndexRes>(
                  dropdownSearchDecoration:
                      const InputDecoration(labelText: 'Index You Want'),
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
              TextButton(
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
                child: const Icon(Icons.add),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(const CircleBorder())),
              )
            ],
          ),
        ),
        ButtonBar(
          children: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("back")),
            ElevatedButton(
                onPressed: _haveSelected != null && offers.isNotEmpty
                    ? () => _create(context)
                    : null,
                child: const Text("create"))
          ],
        )
      ],
    );
    var loadAnim = const AnimationPage(
        asset: LottieAnimations.register, text: "Creating post...");
    return loading ? loadAnim : widget;
  }
}
