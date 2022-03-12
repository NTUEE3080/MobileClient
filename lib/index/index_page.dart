import 'package:coursecupid/core/api_service.dart';
import 'package:coursecupid/core/resp_ext.dart';
import 'package:coursecupid/index/post_view_model.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../api_lib/swagger.swagger.dart';
import '../core/animation.dart';
import 'index_widget.dart';

class IndexPage extends StatefulWidget {
  const IndexPage(
      {Key? key,
      required this.postList,
      required this.api,
      required this.module,
      required this.refresh})
      : super(key: key);
  final List<PostViewModel> postList;
  final ModulePrincipalRes module;
  final ApiService api;
  final Future<void> Function() refresh;

  @override
  State<StatefulWidget> createState() => _ModuleState();
}

class _ModuleState extends State<IndexPage> {
  // constants
  final _biggerFont = const TextStyle(fontSize: 18.0);
  Widget appBarTitle = const Text('Posts');
  Icon _searchIcon = const Icon(Icons.search);

  // States
  final TextEditingController _controller = TextEditingController();
  final RefreshController _rController =
      RefreshController(initialRefresh: false);

  List<PostViewModel> fullList = [];
  List<PostViewModel> filteredList = [];
  String _searchTerm = "";

  _searchListener() {
    if (_controller.text.isEmpty) {
      setState(() {
        _searchTerm = "";
        filteredList = List.from(fullList);
      });
    } else {
      setState(() {
        _searchTerm = _controller.text;
        filteredList = fullList
            .where((x) => _searchTerm.lowerCompare(x.index.code))
            .toList();
      });
    }
  }

  @override
  didUpdateWidget(Widget oldWidget) {
    fullList = widget.postList;
    filteredList = fullList;
    _controller.addListener(_searchListener);
    super.didUpdateWidget(oldWidget as IndexPage);
  }

  @override
  void initState() {
    fullList = widget.postList;
    filteredList = fullList;
    _controller.addListener(_searchListener);
    super.initState();
  }

  void _searchPressed() {
    setState(() {
      if (_searchIcon.icon == Icons.search) {
        _searchIcon = const Icon(Icons.close);
        appBarTitle = Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search...',
                filled: false,
                border: InputBorder.none,
              ),
            ),
          ),
        );
      } else {
        _searchIcon = const Icon(Icons.search);
        appBarTitle = const Text('Posts');
        filteredList = fullList;
        _controller.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var t = Theme.of(context);
    var cs = t.colorScheme;
    var emptyBox = ListView(children: const [
      AnimationFrame(asset: LottieAnimations.emptybox, text: "No post found!")
    ]);
    var list = ListView(
        children: filteredList
            .map((p) => IndexWidget(
                  post: p,
                  api: widget.api,
                  refresh: widget.refresh,
                ))
            .toList());
    var child = filteredList.isEmpty ? emptyBox : list;
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [
            BackButton(
              onPressed: () => Navigator.pop(context),
            ),
            // const Expanded(child: SizedBox(width: 2,)),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  _searchPressed();
                },
                child: _searchIcon,
              ),
            ),
          ],
        ),
        title: appBarTitle,
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: const WaterDropMaterialHeader(
          distance: 80,
        ),
        controller: _rController,
        child: child,
        onRefresh: () async {
          await widget.refresh();
          _rController.refreshCompleted();
        },
      ),
      // body: child,
    );
  }
}
