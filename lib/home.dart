import 'package:coursecupid/core/animation.dart';
import 'package:coursecupid/core/resp_ext.dart';
import 'package:coursecupid/http_error.dart';
import 'package:coursecupid/modules.dart';
import 'package:coursecupid/swagger_generated_code/swagger.swagger.dart';
import "package:flutter/material.dart";

import 'core/api_service.dart';
import 'core/result_ext.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget(
      {Key? key, required this.title, required this.logout, required this.api})
      : super(key: key);
  final String title;
  final VoidCallback logout;
  final ApiService api;

  Future<Result<List<ModulePrincipalRes>, HttpResponseError>>
      getModuleList() async {
    var current = await api.access.currentGet();
    return await current.toResult().thenAsync((curr) async =>
        (await api.access.moduleGet(semester: curr)).toResult());
  }

  @override
  Widget build(BuildContext context) {
    var errorAnimPage = const AnimationPage(
        asset: LottieAnimations.coffee, text: "Error - Cannot list modules");
    var loading = const AnimationPage(
        asset: LottieAnimations.loading, text: "Loading Modules...");
    return FutureBuilder<Result<List<ModulePrincipalRes>, HttpResponseError>>(
        future: getModuleList(),
        builder: (context, val) {
          if (val.hasData) {
            var v = val.data!;
            if (v.isSuccess) {
              return ModulesPage(
                api: api,
                logout: logout,
                title: title,
                moduleList: v.value,
              );
            } else {
              return errorAnimPage;
            }
          }
          return loading;
        });
  }
}
