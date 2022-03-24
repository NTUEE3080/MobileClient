import 'package:coursecupid/api_lib/swagger.swagger.dart';
import 'package:coursecupid/auth/lib/user.dart';
import 'package:coursecupid/core/animation.dart';
import 'package:coursecupid/core/api_service.dart';
import 'package:coursecupid/core/resp_ext.dart';
import 'package:coursecupid/http_error.dart';
import 'package:coursecupid/my_application/contact_widget.dart';
import 'package:flutter/material.dart';

import '../core/result_ext.dart';

class ContactPage extends StatelessWidget {
  final ApplicationRes app;
  final ApiService api;
  final AuthMetaUser user;

  bool get isOwner =>
      app.post?.owner?.id != null && app.post?.owner?.id == user.data?.guid;

  bool get isApplier =>
      app.applied?.owner?.id != null &&
      app.applied?.owner?.id == user.data?.guid;

  const ContactPage(
      {Key? key, required this.app, required this.api, required this.user})
      : super(key: key);

  Future<Result<UserPrincipalResp, HttpResponseError>> _loadUser() async {
    var resp = await api.access.userIdGet(id: app.post?.owner?.id);
    return resp.toResult();
  }

  @override
  Widget build(BuildContext context) {
    var lAnim = const AnimationFrame(
        asset: LottieAnimations.loading, text: "Loading applications...");
    var eAnim = const AnimationFrame(
        asset: LottieAnimations.astronaout, text: "Error - Lost in space");
    return FutureBuilder<Result<UserPrincipalResp, HttpResponseError>>(
        future: _loadUser(),
        builder: (context, val) {
          if (val.connectionState == ConnectionState.done) {
            if (val.hasData) {
              var v = val.data!;
              if (v.isSuccess) {
                return ContactWidget(
                  app: app,
                  user: user,
                  postUser: v.value,
                );
              }
            }
            return eAnim;
          }
          return lAnim;
        });
  }
}
