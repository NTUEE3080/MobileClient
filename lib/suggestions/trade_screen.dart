import 'package:coursecupid/api_lib/swagger.swagger.dart';
import 'package:coursecupid/auth/lib/user.dart';
import 'package:coursecupid/core/animation.dart';
import 'package:coursecupid/core/api_service.dart';
import 'package:coursecupid/core/err_animation.dart';
import 'package:coursecupid/core/resp_ext.dart';
import 'package:coursecupid/http_error.dart';
import 'package:coursecupid/my_application/expandable_indexes.dart';
import 'package:flutter/material.dart';

class TradeScreen extends StatefulWidget {
  final PostPrincipalResp post1;
  final PostPrincipalResp post2;
  final AuthMetaUser user;
  final ApiService api;

  const TradeScreen(
      {Key? key,
      required this.post1,
      required this.post2,
      required this.user,
      required this.api})
      : super(key: key);

  @override
  State<TradeScreen> createState() => _TradeScreenState();
}

class _TradeScreenState extends State<TradeScreen> {
  PostPrincipalResp get p1 => widget.post1.owner?.id == widget.user.data?.guid
      ? widget.post1
      : widget.post2;

  PostPrincipalResp get p2 => widget.post1.owner?.id == widget.user.data?.guid
      ? widget.post2
      : widget.post1;

  IndexPrincipalRes get index1 => p1.index!;

  IndexPrincipalRes get index2 => p2.index!;

  bool get isError => error != null;
  bool isBusy = false;

  HttpResponseError? error;

  setError(HttpResponseError? e) => setState(() => error = e);

  busy() => setState(() => isBusy = true);

  free() => setState(() => isBusy = false);

  @override
  void initState() {
    error = null;
    super.initState();
  }

  Future trade() async {
    busy();
    var r = await widget.api.access
        .applicationPostIdAppIdPost(postId: p2.id, appId: p1.id ?? "");
    var result = r.toResult();
    if (result.isSuccess) {
      setError(null);
      free();
    } else {
      setError(result.error);
      free();
    }
  }

  @override
  Widget build(BuildContext context) {
    var t = Theme.of(context);
    var cs = t.colorScheme;
    var overline = t.textTheme.overline;
    var content = Container(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        children: [
          ListTile(
            title: Row(
              children: [
                Text("${widget.post1.index?.code} ",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            subtitle: Text("${widget.post1.module?.courseCode} "),
            trailing: Chip(
              label: Text(
                "${widget.post1.module?.academicUnit} AU",
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
              padding: const EdgeInsets.only(top: 8),
              child: Text("Trade Details", style: t.textTheme.titleLarge)),
          Container(
            padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text("You are offering", style: overline)),
                    toChip(cs.primary, cs.onPrimary, index1.code)
                  ],
                ),
                const Icon(Icons.arrow_forward),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text("To get their", style: overline)),
                    toChip(cs.primary, cs.onPrimary, index2.code)
                  ],
                )
              ],
            ),
          ),
          const Divider(
            height: 12,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          ExpandableIndex(
            title: "Index Information",
            indexes: [index1, index2],
          ),
          ButtonBar(
            children: [
              ElevatedButton.icon(
                  onPressed: () async {
                    await trade();
                    if (error == null) {
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      textStyle: t.textTheme.bodyMedium,
                      minimumSize: const Size(100, 48)),
                  icon: const Icon(Icons.swap_calls),
                  label: const Text("Trade")),
            ],
          )
        ],
      ),
    );
    const lAnim =
        AnimationFrame(asset: LottieAnimations.loading, text: "loading...");
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back),
        ),
        title: const Text("Trade"),
      ),
      body: isError
          ? HttpErrorAnimationFrame(
              asset: LottieAnimations.coffee,
              text: "Error - Coffee spilled",
              e: error,
            )
          : (isBusy ? lAnim : content),
    );
  }

  Widget toChip(Color c, Color tc, String? text) {
    return Chip(
        backgroundColor: c,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
        label: Text(
          text ?? "Unknown",
          style:
              TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: tc),
        ));
  }
}
