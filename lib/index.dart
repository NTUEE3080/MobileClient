import 'package:coursecupid/core/resp_ext.dart';
import 'package:coursecupid/http_error.dart';
import 'package:coursecupid/swagger_generated_code/swagger.swagger.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'core/animation.dart';
import 'core/api_service.dart';
import 'core/result_ext.dart';

class PostLoader extends StatelessWidget {
  final ApiService api;
  final ModulePrincipalRes module;

  const PostLoader({Key? key, required this.api, required this.module})
      : super(key: key);

  Future<Result<List<PostPrincipalResp>, HttpResponseError>>
      _loadPosts() async {
    return (await api.access.postGet(
      semester: module.semester,
      moduleId: module.id,
    ))
        .toResult();
  }

  @override
  Widget build(BuildContext context) {
    var errorAnimPage = const AnimationPage(
        asset: LottieAnimations.cow, text: "Error - Cannot list posts");
    var loading = const AnimationPage(
        asset: LottieAnimations.loading, text: "Loading Posts...");
    return FutureBuilder<Result<List<PostPrincipalResp>, HttpResponseError>>(
        future: _loadPosts(),
        builder: (context, val) {
          if (val.hasData) {
            var d = val.data!;
            if (d.isSuccess) {
              return IndexPage(
                title: "Posts",
                postList: d.value,
                api: api,
                module: module,
              );
            }
            return errorAnimPage;
          }
          return loading;
        });
  }
}

class IndexPage extends StatefulWidget {
  const IndexPage(
      {Key? key,
      required this.title,
      required this.postList,
      required this.api,
      required this.module})
      : super(key: key);
  final String title;
  final List<PostPrincipalResp> postList;
  final ModulePrincipalRes module;
  final ApiService api;

  @override
  State<StatefulWidget> createState() => _ModuleState();
}

class _ModuleState extends State<IndexPage> {
  // constants
  final _biggerFont = const TextStyle(fontSize: 18.0);
  Icon _searchIcon = const Icon(Icons.search);
  Widget appBarTitle = const Text('Modules');

  // States
  final TextEditingController _controller = TextEditingController();

  List<PostPrincipalResp> fullList = [];
  List<PostPrincipalResp> filteredList = [];
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
        var lower = _searchTerm.toLowerCase();
        filteredList = fullList
            .where((x) =>
                x.index!.code!.toLowerCase().contains(lower) ||
                lower.contains(x.index!.code!.toLowerCase()))
            .toList();
      });
    }
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
        appBarTitle = TextField(
          controller: _controller,
          style: _biggerFont,
          decoration: const InputDecoration(
            hintText: 'Search...',
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
    var emptybox = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            LottieAnimations.emptybox,
            repeat: false,
            width: 300,
            height: 300,
          ),
          const SizedBox(height: 20.0),
          Text(
            "No Posts Found",
            style: GoogleFonts.raleway(
                textStyle: Theme.of(context).textTheme.headline6),
          )
        ],
      ),
    );
    var list = IndexList(filteredList);

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            _searchPressed();
          },
          child: _searchIcon,
        ),
        title: appBarTitle,
      ),
      body: filteredList.isEmpty ? emptybox : list,
    );
  }
}

class IndexWidget extends StatelessWidget {
  final PostPrincipalResp post; // data/state

  const IndexWidget({Key? key, required this.post})
      : super(key: key); // sets the state on construction

  @override
  Widget build(BuildContext context) {
    // build method convert data into visuals
    var chips = post.lookingFor
            ?.map((p) => Chip(
                  padding: const EdgeInsets.all(2),
                  backgroundColor: Colors.deepPurple,
                  label: Text(p.code!,
                      style: const TextStyle(color: Colors.white)),
                ))
            .toList() ??
        [];

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.description),
            title: Text(post.index!.code!),
            subtitle: Row(
              children: chips,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                child: const Text('Apply'),
                onPressed: () {
                  /* ... */
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}

class IndexList extends StatelessWidget {
  final List<PostPrincipalResp> posts; // data

  const IndexList(this.posts, {Key? key}) : super(key: key); // setting the data

  @override
  Widget build(BuildContext context) {
    var children = posts.map((m) => IndexWidget(post: m)).toList();
    return ListView(
      children: children,
    );
  }
}
