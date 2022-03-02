import "package:flutter/material.dart";
import "nav.dart";
import "counter.dart";
import 'multiplier.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key, required this.title, required this.logout}) : super(key: key);
  final String title;
  final VoidCallback logout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: logout, icon: const Icon(Icons.logout, semanticLabel: "logout",))
          ],
          title: Text(title),
        ),
        body: GridView.count(
          crossAxisCount: 2,
          children: [
            NavigationButtonWidget(
              icon: Icons.add_circle,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const Counter(
                          title: 'Counter',
                        )),
              ),
              text: "Counter",
              subtitle: "Increment and Decrement",
            ),
            NavigationButtonWidget(
              icon: Icons.cancel,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const Multiplier(
                      title: 'Multiplier',
                    )),
              ),
              text: "Multiplier",
              subtitle: "Scale up and down numbers",
            )
          ],
        ));
  }
}
