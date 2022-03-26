import 'package:coursecupid/core/debug.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class LottieAnimations {
  static const String register = "assets/register.json";
  static const String loading = "assets/loading.json";
  static const String astronaout = "assets/astronaout.json";
  static const String cat = "assets/cat.json";
  static const String chemical = "assets/chemical.json";
  static const String coffee = "assets/coffee.json";
  static const String cow = "assets/cow.json";
  static const String dogNewsPaper = "assets/dogNewsPaper.json";
  static const String dogSmell = "assets/dogSmell.json";
  static const String dogSwimming = "assets/dogSwimming.json";
  static const String emptybox = "assets/emptybox.json";
  static const String icecream = "assets/icecream.json";
  static const String laptop = "assets/laptop.json";
  static const String lochness = "assets/lochness.json";
  static const String puzzle = "assets/puzzle.json";
  static const String tissue = "assets/tissue.json";
}

const defWidgetList =  <Widget>[];

class AnimationFrame extends StatefulWidget {
  final String asset;
  final String text;
  final List<Widget> widgets;

  const AnimationFrame({Key? key, required this.asset, required this.text, this.widgets = defWidgetList})
      : super(key: key);

  @override
  State<AnimationFrame> createState() => _AnimationFrameState();
}

class _AnimationFrameState extends State<AnimationFrame> {

  int count = 0;

  void increment() => setState(() => count++);

  void resetCount() => setState(() => count = 0);

  void onTap() {
    increment();
    if(count == 7) {
      Navigator.push(context,  MaterialPageRoute(
          builder: (context) => const DebugScreen())
      );
      resetCount();
    }
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                widget.asset,
                width: 300,
                height: 300,
              ),
              const SizedBox(height: 20.0),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Center(
                  child: Text(
                      widget.text,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.raleway(textStyle: Theme
                          .of(context)
                          .textTheme
                          .headline6)
                  ),
                ),
              ),
              ...widget.widgets,
            ],
          ),
        ],
      ),
    );
  }
}

class AnimationPage extends StatelessWidget {
  final String asset;
  final String text;
  final List<Widget> widgets;

  const AnimationPage({Key? key, required this.asset, required this.text, this.widgets = defWidgetList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnimationFrame(asset: asset, text: text, widgets: widgets,),
      ),
    );
  }
}


