import "package:flutter/material.dart";
import 'Indexes.dart';
import 'indexsearch.dart';
//import "nav.dart";
import 'module.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key, required this.title, required this.logout})
      : super(key: key);
  final String title;
  final VoidCallback logout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: logout,
                icon: const Icon(
                  Icons.logout,
                  semanticLabel: "logout",
                ))
          ],
          title: Text(title),
        ),
        body: ModuleList([
          new Module("EE2001", "Circuit Analysis", "CA", 4, [

            Index(1111,'Tut','EE01','Mon', '1030to1150',"TR+89"),
            Index(2222,'Tut','EE02','Tue', '1030to1150',"TR+89"),
            Index(3333,'Tut','EE03','Wed', '1030to1150',"TR+89"),
            Index(4444,'Tut','EE04','Thurs', '1030to1150',"TR+89"),
          ]),
          new Module("EE2002", "Analog Electronics", "AE", 4, [

            Index(1111,'Tut','EE01','Mon', '1030to1150',"TR+89"),
            Index(2222,'Tut','EE02','Tue', '1030to1150',"TR+89"),
            Index(3333,'Tut','EE03','Wed', '1030to1150',"TR+89"),
            Index(4444,'Tut','EE04','Thurs', '1030to1150',"TR+89"),
          ]),
          new Module("EE2003", "Semiconductor Fundamentals", "Semicon", 4, [

            Index(1111,'Tut','EE01','Mon', '1030to1150',"TR+89"),
            Index(2222,'Tut','EE02','Tue', '1030to1150',"TR+89"),
            Index(3333,'Tut','EE03','Wed', '1030to1150',"TR+89"),
            Index(4444,'Tut','EE04','Thurs', '1030to1150',"TR+89"),
          ]),
          new Module("EE2007", "Engineering Mathematics II", "EM2", 4, [
            Index(1111,'Tut','EE01','Mon', '1030to1150',"TR+89"),
            Index(2222,'Tut','EE02','Tue', '1030to1150',"TR+89"),
            Index(3333,'Tut','EE03','Wed', '1030to1150',"TR+89"),
            Index(4444,'Tut','EE04','Thurs', '1030to1150',"TR+89"),
          ]),
    ]));
  }
}

class ModuleWidget extends StatelessWidget {
  final Module module; // data/state

  const ModuleWidget({Key? key, required this.module})
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
                builder: (ctxt) => IndexList(indexes: module.indexes)));
      },
      // displaying the data
      // child: Text(module.code));
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.description),
              title: Text(module.name),
              subtitle: Text(module.description),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: Text('Module Code: ${module.code}'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 10),
                TextButton(
                  child: Text('Course AU: ${module.au}'),
                  onPressed: () {/* ... */},
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
  List<Module> modules; // data

  ModuleList(this.modules, {Key? key}) : super(key: key); // setting the data

  @override
  Widget build(BuildContext context) {
    // what to do with the data

    // List<ModuleWidget> children = [];
    // for (var m in modules) {
    //   var w = ModuleWidget(module: m);
    //   children.add(w);
    // }

    var children = modules.map((m) => ModuleWidget(module: m)).toList();
    return Column(
      children: children,
    );
  }
}

