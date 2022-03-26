import 'package:coursecupid/auth/initial.dart';
import 'package:coursecupid/core/animation.dart';
import 'package:coursecupid/core/err_animation.dart';
import 'package:coursecupid/core/err_expandable.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'lib/auth0.dart';
import 'lib/user.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

typedef Logout = Future<void> Function();
typedef Login = Future<void> Function();

Widget noOp(login, logout, user, message) {
  return const Center();
}

class AuthFrame extends StatefulWidget {
  final ThemeData theme;

  final Widget Function(Login login, Logout logout, AuthMetaUser user, String message) child;

  const AuthFrame({Key? key, required this.child, required this.theme})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _AuthFrameState();
}

class _AuthFrameState extends State<AuthFrame> {
  Widget Function(Login login, Logout logout, AuthMetaUser user, String message) child = noOp;
  bool isBusy = false;
  bool isFatal = false;
  String errorMessage = '';
  Exception? ex;
  StackTrace? st;
  AuthMetaUser user = AuthMetaUser(false, false, false, false, null, null);

  @override
  void initState() {
    initAction();
    super.initState();
    child = widget.child;
  }

  setBusy() => setState(() => isBusy = true);

  setFree() => setState(() => isBusy = false);

  setFatal(Exception e, StackTrace trace){
    setState(() => isFatal = true);
    setState(() => ex = e);
    setState(() => st = trace);
  }

  updateError(String error) => setState(() => errorMessage = error);

  updateUser(AuthMetaUser? r) => setState(
      () => user = r ?? AuthMetaUser(false, false, false, false, null, null));

  Future<void> initAction() async {
    try {
      setBusy();
      var auth = await Auth0.fromPlatform();
      logger.i("start refresh session");
      var user = await auth.refreshSession();
      logger.i("complete refresh session");
      updateUser(user);
      setFree();
    } on Exception catch (e, st) {
      logger.e("Catch exception", e);
      setFatal(e, st);
    }
  }

  Future<void> login() async {
    try {
      setBusy();
      var auth = await Auth0.fromPlatform();
      var r = await auth.login();
      r.match(
          onSuccess: (user) {
            updateUser(user);
            updateError("");
          },
          onError: (e) => updateError(e.title));
      setFree();
    } on Exception catch (e, st) {
      logger.e("Catch exception", e);
      setFatal(e, st);
    }
  }

  Future<void> logout() async {
    try {
      setBusy();
      var auth = await Auth0.fromPlatform();
      var r = await auth.logout();
      updateUser(r);
      updateError("");
      setFree();
    } on Exception catch (e, trace) {
      logger.e("Catch exception", e);
      setFatal(e, trace);
    }
  }

  @override
  Widget build(BuildContext context) {
    var registered = user.loggedIn &&
        user.emailVerified &&
        user.emailFromNTU &&
        user.onboarded;
    var nonError = registered
        ? child(login, logout, user, errorMessage)
        : InitialPage(
      refresh: initAction,
      user: user,
      loginAction: login,
      logoutAction: logout,
      loginError: errorMessage,
      busy: isBusy,
    );
    return MaterialApp(
      title: 'Course Cupid',
      home: isFatal
          ? ExceptionAnimationPage(
              e: ex,
              st: st,
              asset: LottieAnimations.dogSwimming,
              text: "Error - Doggie can't swim")
          : nonError,
      theme: widget.theme,
    );
  }
}
