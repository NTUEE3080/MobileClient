import 'dart:async';

import 'package:coursecupid/api_lib/swagger.swagger.dart';
import 'package:coursecupid/auth/lib/user.dart';
import 'package:coursecupid/core/err_animation.dart';
import 'package:coursecupid/core/resp_ext.dart';
import 'package:coursecupid/http_error.dart';
import 'package:coursecupid/suggestions/suggestion_client.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../core/animation.dart';
import '../core/api_service.dart';
import '../core/result_ext.dart';
import 'filterer.dart';

class SuggestionPage<T> extends StatefulWidget {
  const SuggestionPage(
      {Key? key,
      required this.api,
      required this.controller,
      required this.user,
      required this.client,
      required this.filterer})
      : super(key: key);
  final ApiService api;
  final AuthMetaUser user;
  final TextEditingController controller;
  final SuggestionClient<T> client;
  final Filterer<T> filterer;

  @override
  State<StatefulWidget> createState() => _SuggestionState();
}

class _SuggestionState<T> extends State<SuggestionPage<T>> {
  final RefreshController _refreshController = RefreshController(
    initialRefresh: true,
  );

  // constants
  List<T> fullList = [];
  List<T> filteredList = [];
  List<ApplicationRes> appList = [];
  String? latest;
  String _searchTerm = "";

  bool error = false;
  HttpResponseError? errorMessage;

  setError(HttpResponseError? message) => setState(() {
        error = message != null;
        errorMessage = message;
      });

  Future<Result<List<ApplicationRes>, HttpResponseError>> getAppList() async {
    var posts = widget.api.access.applicationGet(
      posterId: widget.user.data?.guid ?? "non-id",
    );

    var applies = widget.api.access.applicationGet(
      applierId: widget.user.data?.guid ?? "non-id",
    );

    var result = await Future.wait([posts, applies]);

    var r = result.map((x) => x.toResult()).toList();
    return r[0].then((v1) => r[1].mapValue((v2) => [...v1, ...v2]));
  }

  Future<void> _refresh() async {
    var r = await widget.client.get(null, null);
    if (r.isSuccess) {
      var v = r.value;
      latest = v.connector;
      fullList = v.suggestions;
      filteredList = fullList;
    } else {
      setError(r.error);
      return;
    }
    var alR = await getAppList();
    if (alR.isSuccess) {
      appList = alR.value;
    } else {
      setError(alR.error);
      return;
    }
    setError(null);
  }

  _searchListener() {
    if (widget.controller.text.isEmpty) {
      setState(() {
        _searchTerm = "";
        filteredList = List.from(fullList);
      });
    } else {
      setState(() {
        _searchTerm = widget.controller.text;
        filteredList = widget.filterer.search(fullList, _searchTerm);
      });
    }
  }

  @override
  didUpdateWidget(Widget oldWidget) {
    widget.controller.addListener(_searchListener);
    super.didUpdateWidget(oldWidget as SuggestionPage<T>);
  }

  @override
  void initState() {
    widget.controller.addListener(_searchListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var children = filteredList
        .map((a) => widget.client.gen(_refresh, appList, a))
        .toList();
    var empty = const AnimationFrame(
        asset: LottieAnimations.emptybox, text: "No suggestions!");
    var content = filteredList.isEmpty
        ? ListView(children: [empty])
        : ListView(children: children);
    var list = error
        ? ListView(
            children: [
              HttpErrorAnimationFrame(
                asset: LottieAnimations.dogNewsPaper,
                text: "Error - Dog ate newspaper",
                e: errorMessage,
              )
            ],
          )
        : content;
    return SmartRefresher(
        child: list,
        enablePullDown: true,
        enablePullUp: false,
        // onLoading: () async {
        //   await _load();
        //   _refreshController.loadComplete();
        // },
        header: const WaterDropMaterialHeader(
          distance: 80,
        ),
        onRefresh: () async {
          await _refresh();
          _refreshController.refreshCompleted();
        },
        controller: _refreshController);
  }
}
