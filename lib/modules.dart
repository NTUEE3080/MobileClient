import 'package:coursecupid/core/animation.dart';
import 'package:coursecupid/core/api_service.dart';
import 'package:coursecupid/index.dart';
import 'package:coursecupid/swagger_generated_code/swagger.swagger.dart';
import 'package:flutter/material.dart';

import 'create_module_post.dart';

class ModulesPage extends StatefulWidget {
  const ModulesPage(
      {Key? key,
      required this.title,
      required this.logout,
      required this.moduleList,
      required this.api})
      : super(key: key);
  final String title;
  final VoidCallback logout;
  final List<ModulePrincipalRes> moduleList;
  final ApiService api;

  @override
  State<StatefulWidget> createState() => _ModuleState();
}

class _ModuleState extends State<ModulesPage> {
  // constants
  final _biggerFont = const TextStyle(fontSize: 18.0);
  Icon _searchIcon = const Icon(Icons.search);
  Widget appBarTitle = const Text('Modules');

  // States
  final TextEditingController _controller = TextEditingController();

  List<ModulePrincipalRes> fullList = [];
  List<ModulePrincipalRes> filteredList = [];
  String _searchTerm = "";
  String tab = "search";

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
                x.courseCode!.toLowerCase().contains(lower) ||
                lower.contains(x.courseCode!.toLowerCase()) ||
                x.name!.toLowerCase().contains(lower) ||
                lower.contains(x.name!.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  void initState() {
    fullList = widget.moduleList;
    filteredList = fullList;
    _controller.addListener(_searchListener);
    super.initState();
  }

  void _searchPressed(context) {
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
        appBarTitle = const Text('Modules');
        filteredList = fullList;
        _controller.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var page = tab == "search"
        ? ModuleList(filteredList, api: widget.api)
        : const AnimationFrame(
            asset: LottieAnimations.dogNewsPaper,
            text: "Error: Dog Bite Newspaper");

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            _searchPressed(context);
          },
          child: _searchIcon,
        ),
        actions: [
          IconButton(
              onPressed: widget.logout,
              icon: const Icon(
                Icons.logout,
                semanticLabel: "logout",
              ))
        ],
        title: appBarTitle,
      ),
      body: page,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) => CreateModulePost(
                        api: widget.api,
                        modules: widget.moduleList,
                      )));
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        //bottom navigation bar on scaffold
        color: Theme.of(context).colorScheme.primary,
        shape: const CircularNotchedRectangle(),
        //notche margin between floating button and bottom appbar
        child: Expanded(
          child: Row(
            //children inside bottom appbar
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () => setState(() => tab = "search"),
              ),
              IconButton(
                icon: const Icon(
                  Icons.list,
                  color: Colors.white,
                ),
                onPressed: () => setState(() => tab = "list"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ModuleWidget extends StatelessWidget {
  final ModulePrincipalRes module; // data/state
  final ApiService api;

  const ModuleWidget({Key? key, required this.module, required this.api})
      : super(key: key); // sets the state on construction

  @override
  Widget build(BuildContext context) {
    // build method convert data into visuals
    return GestureDetector(
      // what action to perform when child is tapped
      onTap: () {
        // opening new page
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => PostLoader(
                      api: api,
                      module: module,
                    )));
      },
      // displaying the data
      // child: Text(module.code));
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.description),
              title: Text(module.name!),
              subtitle: Text(module.description!),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: Text('Module Code: ${module.courseCode!}'),
                  onPressed: () {
                    /* ... */
                  },
                ),
                const SizedBox(width: 10),
                TextButton(
                  child: Text('Course AU: ${module.academicUnit!}'),
                  onPressed: () {
                    /* ... */
                  },
                ),
                const SizedBox(width: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ModuleList extends StatelessWidget {
  final List<ModulePrincipalRes> modules; // data
  final ApiService api;

  const ModuleList(this.modules, {Key? key, required this.api})
      : super(key: key); // setting the data

  @override
  Widget build(BuildContext context) {
    var children =
        modules.map((m) => ModuleWidget(module: m, api: api)).toList();
    return ListView(
      children: children,
    );
  }
}
