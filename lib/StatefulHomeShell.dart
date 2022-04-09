import 'package:coursecupid/auth/lib/user.dart';
import 'package:coursecupid/module/modules_page.dart';
import 'package:coursecupid/my_application/application_loader.dart';
import 'package:coursecupid/post_creation/create_module_post.dart';
import 'package:coursecupid/suggestions/filterer.dart';
import 'package:coursecupid/suggestions/suggestion_client.dart';
import 'package:coursecupid/suggestions/suggestion_page.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

import 'api_lib/swagger.swagger.dart';
import 'bar_buttons.dart';
import 'core/api_service.dart';
import 'dynamic_theme/theme_widget_setting.dart';

class BottomTabs {
  static const String module = "Modules";
  static const String applications = "Applications";
  static const String settings = "Settings";
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
  int tabSize = 6;

  void _searchPressed(context) {
    setState(() {
      if (_searchIcon.icon == Icons.search) {
        _searchIcon = const Icon(Icons.close);
        appBarTitle = Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(5)),
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
        var rejected = ApplicationLoader(
            loadType: AppLoadType.rejected,
            api: widget.api,
            user: widget.user,
            controller: _controller);
        var applied = ApplicationLoader(
            loadType: AppLoadType.applied,
            api: widget.api,
            user: widget.user,
            controller: _controller);
        var offer = ApplicationLoader(
            loadType: AppLoadType.offer,
            api: widget.api,
            user: widget.user,
            controller: _controller);
        var done = ApplicationLoader(
            loadType: AppLoadType.done,
            api: widget.api,
            user: widget.user,
            controller: _controller);
        var sug2client = TwoWaySuggestionClient(widget.api, widget.user);
        var sug3client = ThreeWaySuggestionClient(widget.api, widget.user);
        var sug2f = TwoWaySuggestionFilterer();
        var sug3f = ThreeWaySuggestionFilterer();
        var twoSuggestions = SuggestionPage<TwoWaySuggestionResp>(
            api: widget.api,
            controller: _controller,
            user: widget.user,
            client: sug2client,
            filterer: sug2f);
        var threeSuggestions = SuggestionPage<ThreeWaySuggestionResp>(
            api: widget.api,
            controller: _controller,
            user: widget.user,
            client: sug3client,
            filterer: sug3f);
        page = TabBarView(
          children: [
            rejected,
            applied,
            offer,
            done,
            twoSuggestions,
            threeSuggestions,
          ],
        );
        break;
      case BottomTabs.settings:
        page = ThemeSetting(
          controller: _controller,
        );
    }
    var tabBar = btmTab == BottomTabs.applications
        ? const TabBar(isScrollable: true, tabs: [
            Tab(icon: Icon(Icons.thumb_down_alt), text: "Rejected"),
            Tab(icon: Icon(Icons.approval), text: "Applied"),
            Tab(icon: Icon(Icons.local_offer), text: "Offers"),
            Tab(icon: Icon(Icons.task_alt), text: "Completed"),
            Tab(
                icon: Icon(
                  Mdi.numeric2BoxMultipleOutline,
                ),
                text: "Suggestions"),
            Tab(
                icon: Icon(
                  Mdi.numeric3BoxMultipleOutline,
                ),
                text: "Suggestions"),
          ])
        : null;
    return DefaultTabController(
      length: tabSize,
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
                const SizedBox(width: 16),
                BottomBarButton(
                  icon: Icons.settings,
                  onPressed: () => _switchBottomTabs(BottomTabs.settings),
                  text: 'Settings',
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
