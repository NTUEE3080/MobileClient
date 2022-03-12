import 'package:coursecupid/api_lib/swagger.swagger.dart';
import 'package:coursecupid/auth/lib/user.dart';
import 'package:coursecupid/core/animation.dart';
import 'package:coursecupid/core/api_service.dart';
import 'package:coursecupid/core/resp_ext.dart';
import 'package:coursecupid/core/result_ext.dart';
import 'package:coursecupid/http_error.dart';
import 'package:coursecupid/my_application/application_page.dart';
import 'package:flutter/material.dart';

class AppLoadType {
  static const String My = "My";
  static const String Offer = "Offer";
  static const String Done = "Done";
}

class ApplicationLoader extends StatefulWidget {
  final VoidCallback logout;
  final ApiService api;
  final AuthMetaUser user;
  final TextEditingController controller;
  final String loadType;

  const ApplicationLoader(
      {Key? key,
      required this.logout,
      required this.api,
      required this.user,
      required this.controller,
      required this.loadType})
      : super(key: key);

  @override
  State<ApplicationLoader> createState() => _ApplicationLoaderState();
}

class _ApplicationLoaderState extends State<ApplicationLoader> {
  Future<Result<List<ApplicationRes>, HttpResponseError>> _getOffer() async {
    var r = await widget.api.access.applicationFullGet(
      accepterId: widget.user.data?.guid ?? "",
    );
    return r.toResult().mapValue((value) => value
        .where((element) => element.principal?.status == "pending")
        .toList());
  }

  Future<Result<List<ApplicationRes>, HttpResponseError>>
      _getOfferDone() async {
    var r = await widget.api.access.applicationFullGet(
      accepterId: widget.user.data?.guid ?? "",
    );
    return r.toResult().mapValue((value) => value
        .where((element) => element.principal?.status == "accepted")
        .toList());
  }

  Future<Result<List<ApplicationRes>, HttpResponseError>> _getMyDone() async {
    var r = await widget.api.access.applicationFullGet(
      applierId: widget.user.data?.guid ?? "",
    );
    return r.toResult().mapValue((value) => value
        .where((element) => element.principal?.status == "accepted")
        .toList());
  }

  Future<Result<List<ApplicationRes>, HttpResponseError>> _getDone() async {
    return await _getMyDone().andThenAsync(
        (value) => _getOfferDone().thenMap((v) => [...value, ...v]));
  }

  Future<Result<List<ApplicationRes>, HttpResponseError>> _getMy() async {
    var r = await widget.api.access.applicationFullGet(
      applierId: widget.user.data?.guid ?? "",
    );
    return r.toResult().mapValue((value) => value
        .where((element) => element.principal?.status != "accepted")
        .toList());
  }

  Future<Result<List<ApplicationRes>, HttpResponseError>> _getApplications() {
    var e = HttpResponseError(
      type: "Local Client Error",
      title: "Unknown App Load Type",
      status: 600,
      traceId: "none",
      instance: "none",
      detail: "Unknown AppLoadType: ${widget.loadType}",
    );

    switch (widget.loadType) {
      case AppLoadType.Done:
        return _getDone();
      case AppLoadType.My:
        return _getMy();
      case AppLoadType.Offer:
        return _getOffer();
      default:
        return Future.value(Result.error(e));
    }
  }

  Result<List<ApplicationRes>, HttpResponseError>? result;

  @override
  initState() {
    _refresh();
    super.initState();
  }

  Future<void> _refresh() async {
    var r = await _getApplications();
    setState(() => result = r);
  }

  @override
  Widget build(BuildContext context) {
    var lAnim = const AnimationFrame(
        asset: LottieAnimations.loading, text: "Loading applications...");
    var eAnim = const AnimationFrame(
        asset: LottieAnimations.astronaout, text: "Error - Lost in space");
    if (result == null) {
      return lAnim;
    } else if (result!.isSuccess) {
      return ApplicationPage(
        logout: widget.logout,
        appList: result!.value,
        controller: widget.controller,
        user: widget.user,
        api: widget.api,
        refresh: _refresh,
      );
    } else {
      return eAnim;
    }
  }
}
