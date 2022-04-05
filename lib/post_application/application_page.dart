import 'package:coursecupid/auth/frame.dart';
import 'package:coursecupid/auth/lib/user.dart';
import 'package:coursecupid/core/resp_ext.dart';
import 'package:coursecupid/post_application/application_create_header.dart';
import 'package:coursecupid/post_application/post_application_load.dart';
import 'package:coursecupid/post_application/single_post_widget.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../api_lib/swagger.swagger.dart';
import '../components/error_renderer.dart';
import '../core/animation.dart';
import '../core/api_service.dart';
import '../http_error.dart';
import '../post_creation/create_module_post.dart';

class CreateApplicationPage extends StatefulWidget {
  final ApplicationViewModel vm;
  final ApiService api;
  final AuthMetaUser user;
  final List<ModulePrincipalRes> modules;

  const CreateApplicationPage(
      {Key? key,
      required this.vm,
      required this.api,
      required this.user,
      required this.modules})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CreateModulePost();
}

class _CreateModulePost extends State<CreateApplicationPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  bool networkError = false;
  HttpResponseError? createErr;
  List<int> isLoading = [];
  List<PostPrincipalResp> posts = [];

  Future<void> _refresh() async {
    var r = await widget.api.access.postGet(
      completed: false,
      posterId: widget.user.data?.guid ?? "non-id",
      moduleId: widget.vm.post.post?.module?.id ?? "non-id",
    );
    var result = r.toResult();
    if (result.isSuccess) {
      networkNoErr();
      var d = result.value;
      setState(() {
        posts = d;
      });
    } else {
      networkErr();
      logger.e(result.error);
    }
  }

  networkErr() => setState(() => networkError = true);

  networkNoErr() => setState(() => networkError = false);

  busy() => setState(() => isLoading.add(0));

  free() => setState(() => isLoading.removeLast());

  Future<void> Function(String?) _create(BuildContext context) {
    return (String? offerId) async {
      busy();
      var r = await widget.api.access.applicationPostIdAppIdPost(
          postId: widget.vm.post.post?.id ?? "", appId: offerId ?? "");
      var result = r.toResult();
      if (result.isSuccess) {
        setError(null);
        free();
        Navigator.pop(context);
      } else {
        setError(result.error);
        free();
      }
    };
  }

  setError(HttpResponseError? err) {
    setState(() => createErr = err);
  }

  @override
  Widget build(BuildContext context) {
    var t = Theme.of(context);
    var box20 = const SizedBox(height: 20);
    var errWidget = createErr == null
        ? box20
        : Container(
            padding: const EdgeInsets.all(24), child: ErrorDisplay(createErr!));
    var loadAnim = const AnimationPage(
        asset: LottieAnimations.register, text: "Applying...");
    var errAnim = ListView(
      children: const [
        AnimationFrame(
            asset: LottieAnimations.coffee, text: "Error - coffee spilled"),
      ],
    );

    var p = widget.vm.post.post;
    var offers = p?.lookingFor ?? <IndexPrincipalRes>[];

    var postList = posts.isEmpty
        ? ListView(
            children: [
              AnimationFrame(
                  asset: LottieAnimations.emptybox,
                  text: "You don't have any post for ${p?.module?.courseCode}!")
            ],
          )
        : ListView(
            padding: const EdgeInsets.all(8),
            children: posts
                .map((post) => SinglePostWidget(
                      create: _create(context),
                      have: p!.index!,
                      lookingFor: offers,
                      post: post,
                    ))
                .toList(),
          );

    var pageContent = Column(children: [
      errWidget,
      CreateApplicationHeader(p: p),
      Text("Trade With (your existing posts)", style: t.textTheme.overline),
      Expanded(
        child: SmartRefresher(
          child: networkError ? errAnim : postList,
          enablePullDown: true,
          enablePullUp: false,
          onRefresh: () async {
            await _refresh();
            _refreshController.refreshCompleted();
          },
          controller: _refreshController,
        ),
      )
    ]);
    var page = Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
        title: Text(
            "Trade with ${widget.vm.post.post?.module?.courseCode ?? ''} - ${widget.vm.post.post?.index?.code ?? ''}"),
      ),
      body: pageContent,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) => CreateModulePost(
                        initOffers: [widget.vm.post.post!.index!.id!],
                        initModule: widget.vm.post.post?.module,
                        api: widget.api,
                        modules: widget.modules,
                      ))).then((value) async => await _refresh());
        },
      ),
    );

    return isLoading.isNotEmpty ? loadAnim : page;
  }
}
