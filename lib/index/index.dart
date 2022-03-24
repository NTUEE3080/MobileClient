import 'package:coursecupid/auth/lib/user.dart';
import 'package:coursecupid/core/resp_ext.dart';
import 'package:coursecupid/http_error.dart';
import 'package:coursecupid/index/post_view_model.dart';
import 'package:flutter/material.dart';

import '../api_lib/swagger.swagger.dart';
import '../core/animation.dart';
import '../core/api_service.dart';
import '../core/result_ext.dart';
import 'index_page.dart';

class PostLoader extends StatefulWidget {
  final ApiService api;
  final ModulePrincipalRes module;
  final AuthMetaUser user;
  final List<ModulePrincipalRes> modules;

  const PostLoader(
      {Key? key,
      required this.api,
      required this.module,
      required this.user,
      required this.modules})
      : super(key: key);

  @override
  State<PostLoader> createState() => _PostLoaderState();
}

class _PostLoaderState extends State<PostLoader> {
  Future<Result<List<PostViewModel>, HttpResponseError>>
      _loadViewModels() async {
    return await _loadPosts().thenMap((posts) {
      return posts.map((p) => PostViewModel.from(p, widget.user)).toList();
    });
  }

  Future<Result<List<PostPrincipalResp>, HttpResponseError>>
      _loadPosts() async {
    return (await widget.api.access.postGet(
      semester: widget.module.semester,
      moduleId: widget.module.id,
      curateFor: widget.user.data?.guid,
      completed: false,
    ))
        .toResult();
  }

  Result<List<PostViewModel>, HttpResponseError>? result;

  @override
  initState() {
    _refresh();
    super.initState();
  }

  Future<void> _refresh() async {
    var r = await _loadViewModels();
    setState(() => result = r);
  }

  @override
  Widget build(BuildContext context) {
    var errorAnimPage = const AnimationPage(
        asset: LottieAnimations.cow, text: "Error - Cannot list posts");
    var loading = const AnimationPage(
        asset: LottieAnimations.loading, text: "Loading Posts...");

    if (result == null) {
      return loading;
    } else if (result!.isSuccess) {
      return IndexPage(
        user: widget.user,
        postList: result!.value,
        api: widget.api,
        module: widget.module,
        refresh: _refresh,
        modules: widget.modules,
      );
    } else {
      return errorAnimPage;
    }
  }
}
