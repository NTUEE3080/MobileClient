import 'package:coursecupid/api_lib/swagger.swagger.dart';
import 'package:coursecupid/auth/lib/user.dart';
import 'package:coursecupid/core/animation.dart';
import 'package:coursecupid/core/api_service.dart';
import 'package:coursecupid/core/resp_ext.dart';
import 'package:coursecupid/core/result_ext.dart';
import 'package:coursecupid/http_error.dart';
import 'package:coursecupid/post_application/application_page.dart';
import 'package:flutter/material.dart';

class ApplicationViewModel {
  final List<IndexRes> indexes;
  final PostResp post;

  ApplicationViewModel(this.indexes, this.post);
}

class PostApplicationLoader extends StatelessWidget {
  final ApiService api;
  final String postId;
  final AuthMetaUser user;
  final List<ModulePrincipalRes> modules;

  const PostApplicationLoader(
      {Key? key,
      required this.api,
      required this.postId,
      required this.user,
      required this.modules})
      : super(key: key);

  Future<Result<ApplicationViewModel, HttpResponseError>> _getVM() async {
    var r = await _loadPost();
    return r.thenAsync((post) => _getIndexList(post.post?.module)
        .thenMap((indexes) => ApplicationViewModel(indexes, post)));
  }

  Future<Result<List<IndexRes>, HttpResponseError>> _getIndexList(
      ModulePrincipalRes? module) async {
    var noe = HttpResponseError(
      type: 'No Module',
      traceId: 'none',
      title: "Module not found",
      status: 404,
      detail: "Module from loading full post not found",
      instance: "none",
      errors: noOpError,
    );
    if (module == null) return Future.value(Result.error(noe));
    return (await api.access.indexGet(
      semester: module.semester,
      course: module.id,
    ))
        .toResult();
  }

  Future<Result<PostResp, HttpResponseError>> _loadPost() async {
    var resp = await api.access.postIdGet(id: postId);
    return resp.toResult();
  }

  @override
  Widget build(BuildContext context) {
    var eAnim = const AnimationPage(
        asset: LottieAnimations.tissue, text: "Error - no more tissue");
    var loading = const AnimationPage(
        asset: LottieAnimations.loading, text: "Loading post and indexes");
    return FutureBuilder<Result<ApplicationViewModel, HttpResponseError>>(
      future: _getVM(),
      builder: (context, val) {
        if (val.connectionState == ConnectionState.done) {
          if (val.hasData) {
            var d = val.data!;
            if (d.isSuccess) {
              return CreateApplicationPage(
                user: user,
                api: api,
                vm: d.value,
                modules: modules,
              );
            }
            logger.e(d.error.type);
            logger.e(d.error.title);
            logger.e(d.error.instance);
            logger.e(d.error.detail);
            logger.e(d.error.status);
          } else {
            logger.e("No data, checking error: ");
            logger.e(val.error);
            logger.e(val.stackTrace);
          }
          return eAnim;
        }
        return loading;
      },
    );
  }
}
