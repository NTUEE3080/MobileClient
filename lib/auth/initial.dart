import 'package:coursecupid/auth/onboard.dart';
import 'package:coursecupid/core/animation.dart';
import 'package:coursecupid/auth/home.dart';
import 'package:coursecupid/auth/lib/user.dart';
import 'package:coursecupid/auth/verify_email.dart';
import 'package:flutter/material.dart';

import 'error.dart';

class InitialPage extends StatelessWidget {
  const InitialPage(
      {Key? key,
      required this.refresh,
      required this.logoutAction,
      required this.user,
      required this.loginAction,
      this.loginError = '',
      required this.busy})
      : super(key: key);
  final bool busy;
  final AuthMetaUser user;
  final VoidCallback refresh;
  final VoidCallback loginAction;
  final String loginError;
  final VoidCallback logoutAction;

  @override
  Widget build(BuildContext context) {

    var emailPage = VerifyEmailPage(
        refresh: refresh,
        logout: logoutAction,
        message: "Please verify your email");
    var onboardPage = OnboardPage(user, refresh);
    var com = user.loggedIn
        ? (user.emailFromNTU
            ? (user.emailVerified ? onboardPage : emailPage )
            : ErrorPage(
                logoutAction: logoutAction,
                message: "You need to sign up with an NTU email",
              ))
        : InitialHomePage(loginAction: loginAction, loginError: loginError);

    return busy
        ? const AnimationPage(asset: LottieAnimations.loading, text: "loading...")
        : com;
  }
}
