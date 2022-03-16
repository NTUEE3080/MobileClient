import 'package:coursecupid/auth/lib/user.dart';
import 'package:coursecupid/module/modules_page.dart';
import 'package:coursecupid/my_application/application_loader.dart';
import 'package:coursecupid/post_creation/create_module_post.dart';
import 'package:flutter/material.dart';

import 'api_lib/swagger.swagger.dart';
import 'bar_buttons.dart';
import 'core/api_service.dart';

class BottomTabs {
  static const String module = "Modules";
  static const String applications = "Applications";
}

class TopTabs {
  static const String my = "Mine";
  static const String offer = "Offers";
  static const String done = "Done";
}

class StatefulHomeShell extends StatefulWidget {
  const StatefulHomeShell(
      {Key? key,
      required this.title,
      required this.logout,
      required this.moduleList,
      required this.api,
      required this.user})
      : super(key: key);

  final String title;
  final VoidCallback logout;
  final ApiService api;
  final List<ModulePrincipalRes> moduleList;
  final AuthMetaUser user;

  @override
  State<StatefulWidget> createState() => _ModuleState();
}

class _ModuleState extends State<StatefulHomeShell> {
  // static constants

  // constants
  Icon _searchIcon = const Icon(Icons.search);

  // States
  TextEditingController _controller = TextEditingController();
  String btmTab = BottomTabs.module;
  Widget appBarTitle = const Text(BottomTabs.module);

  void _searchPressed(context) {
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
        appBarTitle = Text(btmTab);
        _controller.clear();
      }
    });
  }

  _switchTopTabs(String t) {
    setState(() {
      appBarTitle = Text(t);
      _searchIcon = const Icon(Icons.search);
      _controller.clear();
    });
    setState(() => _controller = TextEditingController());
    setState(() => btmTab = t);
  }

  _switchBottomTabs(String t) {
    setState(() {
      appBarTitle = Text(t);
      _searchIcon = const Icon(Icons.search);
      _controller.clear();
    });
    setState(() => _controller = TextEditingController());
    setState(() => btmTab = t);
  }

  @override
  Widget build(BuildContext context) {
    var t = Theme.of(context);
    var cs = t.colorScheme;
    late Widget page;
    switch (btmTab) {
      case BottomTabs.module:
        page = ModulesPage(
            logout: widget.logout,
            api: widget.api,
            user: widget.user,
            controller: _controller,
            moduleList: widget.moduleList);
        break;
      case BottomTabs.applications:
        var my = ApplicationLoader(
            logout: widget.logout,
            loadType: AppLoadType.My,
            api: widget.api,
            user: widget.user,
            controller: _controller);
        var offer = ApplicationLoader(
            logout: widget.logout,
            loadType: AppLoadType.Offer,
            api: widget.api,
            user: widget.user,
            controller: _controller);
        var done = ApplicationLoader(
            logout: widget.logout,
            loadType: AppLoadType.Done,
            api: widget.api,
            user: widget.user,
            controller: _controller);
        page = TabBarView(
          children: [
            my,
            offer,
            done,
          ],
        );
        break;
    }
    var tabBar = btmTab == BottomTabs.applications
        ? const TabBar(tabs: [
            Tab(icon: Icon(Icons.approval), text: "Applied"),
            Tab(icon: Icon(Icons.local_offer), text: "Offers"),
            Tab(icon: Icon(Icons.task_alt), text: "Completed"),
          ])
        : null;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
          bottom: tabBar,
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
          color: Theme.of(context).primaryColor,
          shape: const CircularNotchedRectangle(),
          child: Container(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BottomBarButton(
                  icon: Icons.search,
                  onPressed: () => _switchBottomTabs(BottomTabs.module),
                  text: 'Search',
                ),
                BottomBarButton(
                  icon: Icons.list,
                  onPressed: () => _switchBottomTabs(BottomTabs.applications),
                  text: 'Applications',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
