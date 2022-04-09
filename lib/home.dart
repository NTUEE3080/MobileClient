import 'package:coursecupid/StatefulHomeShell.dart';
import 'package:coursecupid/auth/lib/user.dart';
import 'package:coursecupid/core/animation.dart';
import 'package:coursecupid/core/err_animation.dart';
import 'package:coursecupid/core/resp_ext.dart';
import 'package:coursecupid/http_error.dart';
import "package:flutter/material.dart";

import 'api_lib/swagger.swagger.dart';
import 'core/api_service.dart';
import 'core/result_ext.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget(
      {Key? key,
      required this.title,
      required this.logout,
      required this.api,
      required this.user})
      : super(key: key);
  final String title;
  final VoidCallback logout;
  final ApiService api;
  final AuthMetaUser user;

  Future<Result<List<ModulePrincipalRes>, HttpResponseError>>
      getModuleList() async {
    var current = await api.access.currentGet();
    return await current.toResult().thenAsync((curr) async =>
        (await api.access.moduleGet(semester: curr)).toResult());
  }

  @override
  Widget build(BuildContext context) {
    var loading = const AnimationPage(
        asset: LottieAnimations.loading, text: "Loading Modules...");
    return FutureBuilder<Result<List<ModulePrincipalRes>, HttpResponseError>>(
        future: getModuleList(),
        builder: (context, val) {
          if (val.connectionState == ConnectionState.done) {
            if (val.hasData) {
              var v = val.data!;
              if (v.isSuccess) {
                return StatefulHomeShell(
                  user: user,
                  api: api,
                  logout: logout,
                  title: title,
                  moduleList: v.value,
                );
              } else {
                return HttpErrorAnimationPage(
                  asset: LottieAnimations.coffee,
                  text: "Error - Cannot list modules",
                  e: v.error,
                );
              }
            } else {
              return ExceptionAnimationPage(
                asset: LottieAnimations.coffee,
                text: "Error - Cannot list modules",
                e: val.error as Exception?,
                st: val.stackTrace,
              );
            }
          }
          return loading;
        });
  }
}
