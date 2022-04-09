import 'package:coursecupid/auth/lib/user.dart';
import 'package:coursecupid/core/resp_ext.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../api_lib/swagger.swagger.dart';
import '../core/animation.dart';
import '../core/api_service.dart';
import 'application_widget.dart';

class ApplicationPage extends StatefulWidget {
  const ApplicationPage(
      {Key? key,
      required this.appList,
      required this.api,
      required this.controller,
      required this.user,
      required this.refresh})
      : super(key: key);
  final ApiService api;
  final AuthMetaUser user;
  final List<ApplicationRes> appList;
  final TextEditingController controller;
  final Future<void> Function() refresh;

  @override
  State<StatefulWidget> createState() => _ApplicationState();
}

class _ApplicationState extends State<ApplicationPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  // constants
  List<ApplicationRes> fullList = [];
  List<ApplicationRes> filteredList = [];
  String _searchTerm = "";

  _searchListener() {
    if (widget.controller.text.isEmpty) {
      setState(() {
        _searchTerm = "";
        filteredList = List.from(fullList);
      });
    } else {
      setState(() {
        _searchTerm = widget.controller.text;
        filteredList = fullList
            .where((x) =>
                _searchTerm.lowerCompare(x.post?.module?.courseCode) ||
                _searchTerm.lowerCompare(x.post?.module?.name) ||
                _searchTerm.lowerCompare(x.post?.index?.code))
            .toList();
      });
    }
  }

  @override
  didUpdateWidget(Widget oldWidget) {
    fullList = widget.appList;
    filteredList = fullList;
    widget.controller.addListener(_searchListener);
    super.didUpdateWidget(oldWidget as ApplicationPage);
  }

  @override
  void initState() {
    fullList = widget.appList;
    filteredList = fullList;
    widget.controller.addListener(_searchListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var children = filteredList
        .map((a) => ApplicationWidget(
              app: a,
              api: widget.api,
              user: widget.user,
              refresh: widget.refresh,
            ))
        .toList();
    var empty = const AnimationFrame(
        asset: LottieAnimations.emptybox, text: "Nothing here");
    var list = filteredList.isEmpty
        ? ListView(children: [empty])
        : ListView(children: children);
    return SmartRefresher(
        child: list,
        enablePullDown: true,
        enablePullUp: false,
        header: const WaterDropMaterialHeader(
          distance: 80,
        ),
        onRefresh: () async {
          await widget.refresh();
          _refreshController.refreshCompleted();
        },
        controller: _refreshController);
  }
}
