import 'package:coursecupid/core/animation.dart';
import 'package:coursecupid/core/app_config.dart';
import 'package:flutter/material.dart';

class DebugWidget extends StatelessWidget {
  final AppConfiguration config;

  const DebugWidget({Key? key, required this.config}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Debug Info'),
          ),
          body: Center(
              child: Column(children: [
                Container(
                  margin: const EdgeInsets.all(5),
                  child: Table(
                    border: TableBorder.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 1
                    ),
                    children: [
                      TableRow(children: [
                        Column(children: const [Text("Package Name")]),
                        Column(children: [Text(config.packageName)]),
                      ]),
                      TableRow(children: [
                        Column(children: const [Text("Application Name")]),
                        Column(children: [Text(config.appName)]),
                      ]),
                      TableRow(children: [
                        Column(children: const [Text("Build Number")]),
                        Column(children: [Text(config.buildNumber)]),
                      ]),
                      TableRow(children: [
                        Column(children: const [Text("Version")]),
                        Column(children: [Text(config.version)]),
                      ]),
                      TableRow(children: [
                        Column(children: const [Text("Auth Domain")]),
                        Column(children: [Text(config.authDomain)]),
                      ]),
                      TableRow(children: [
                        Column(children: const [Text("Auth ClientId")]),
                        Column(children: [Text(config.authClientId)]),
                      ]),
                      TableRow(children: [
                        Column(children: const [Text("Git Branch")]),
                        Column(children: [Text(config.gitBranch)]),
                      ]),
                      TableRow(children: [
                        Column(children: const [Text("Git SHA")]),
                        Column(children: [Text(config.gitSha)]),
                      ]),
                    ],
                  ),
                ),
              ])
          )),
    );
  }
}

class DebugScreen extends StatelessWidget {
  const DebugScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AppConfiguration>(
      future: AppConfiguration.fromPlatform(),
      builder: (context, val) {
        if (val.hasData) {
          var config = val.data!;
          return DebugWidget(config: config);
        } else if (val.hasError) {
          return const AnimationPage(
              asset: LottieAnimations.dogSwimming,
              text: "Error - Doggie can't swim");
        } else {
          return const AnimationPage(
              asset: LottieAnimations.loading, text: "Loading...");
        }
      },
    );
  }
}
