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

  const PostLoader(
      {Key? key, required this.api, required this.module, required this.user})
      : super(key: key);

  @override
  State<PostLoader> createState() => _PostLoaderState();
}

class _PostLoaderState extends State<PostLoader> {
  Future<Result<List<PostViewModel>, HttpResponseError>>
      _loadViewModels() async {
    return await _loadPosts().andThenAsync((posts) async {
      var apps = await _loadApplications();
      return apps.mapValue((a) =>
          posts.map((p) => PostViewModel.from(p, a, widget.user)).toList());
    });
  }

  Future<Result<List<ApplicationPrincipalRes>, HttpResponseError>>
      _loadApplications() async {
    Result<String, HttpResponseError> userR = widget.user.data?.guid == null
        ? Result.error(HttpResponseError(
            type: "User not found",
            instance: "user",
            detail:
                "User data not found despite being logged in, perhaps onboarding skipped?",
            status: 401,
            title: "User data not found",
            traceId: "none",
            errors: noOpError,
          ))
        : Result.ok(widget.user.data!.guid);
    return await userR.thenAsync((uid) async {
      var r = await widget.api.access
          .applicationGet(moduleId: widget.module.id, applierId: uid);
      return r.toResult();
    });
  }

  Future<Result<List<PostPrincipalResp>, HttpResponseError>>
      _loadPosts() async {
    return (await widget.api.access.postGet(
      semester: widget.module.semester,
      moduleId: widget.module.id,
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
    }else if(result!.isSuccess) {
      return IndexPage(
          postList: result!.value,
          api: widget.api,
          module: widget.module,
          refresh: _refresh,
      );

    } else {
      return errorAnimPage;
    }
  }
}
