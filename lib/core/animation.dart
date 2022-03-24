import 'package:coursecupid/core/blank.dart';
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

class AnimationFrame extends StatelessWidget {
  final String asset;
  final String text;

  const AnimationFrame({Key? key, required this.asset, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              asset,
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
                    text,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.raleway(textStyle: Theme
                        .of(context)
                        .textTheme
                        .headline6)
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

class AnimationPage extends StatelessWidget {
  final String asset;
  final String text;

  const AnimationPage({Key? key, required this.asset, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EmptyPage(
      children: [
        Lottie.asset(
          asset,
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
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: GoogleFonts.raleway(
                textStyle: Theme
                    .of(context)
                    .textTheme
                    .headline6),
          ),
        )
      ],
    );
  }
}
