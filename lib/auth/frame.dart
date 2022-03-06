import 'package:coursecupid/auth/initial.dart';
import 'package:coursecupid/core/animation.dart';
import 'package:coursecupid/core/app_config.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../core/api_service.dart';
import 'lib/auth0.dart';
import 'lib/user.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

typedef Logout = Future<void> Function();
typedef Login = Future<void> Function();

Widget noOp(login, logout, message) {
  return const Center();
}

class AuthFrame extends StatefulWidget {
  final Widget Function(Login login, Logout logout, String message) child;

  const AuthFrame({Key? key, required this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AuthFrameState();
}

class _AuthFrameState extends State<AuthFrame> {
  Widget Function(Login login, Logout logout, String message) child = noOp;
  bool isBusy = false;
  bool isFatal = false;
  String errorMessage = '';
  AuthMetaUser user = AuthMetaUser(false, false, false, false, null);

  @override
  void initState() {
    initAction();
    super.initState();
    child = widget.child;
  }

  setBusy() => setState(() => isBusy = true);

  setFree() => setState(() => isBusy = false);

  setFatal() => setState(() => isFatal = true);

  updateError(String error) => setState(() => errorMessage = error);

  updateUser(AuthMetaUser? r) =>
      setState(
              () => user = r ?? AuthMetaUser(false, false, false, false, null));

  Future<void> initAction() async {
    try {
      setBusy();
      var auth = await Auth0.fromPlatform();
      logger.i("start refresh session");
      var user = await auth.refreshSession();
      logger.i(user);
      logger.i("complete refresh session");
      var api = await ApiService.fromPlatform();
      var r = await api.access.userIdGet(id: "id");
      if (!r.isSuccessful) {
        logger.i(r.error.runtimeType);
      }
      updateUser(user);
      setFree();
    } on Exception catch (e) {
      logger.e("Catch exception", e);
      setFatal();
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
          onError: (e) => updateError(e));
      setFree();
    } on Exception catch (e) {
      logger.e("Catch exception", e);
      setFatal();
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
    } on Exception catch (e) {
      logger.e("Catch exception", e);
      setFatal();
    }
  }

  @override
  Widget build(BuildContext context) {
    var registered = user.loggedIn &&
        user.emailVerified &&
        user.emailFromNTU &&
        user.onboarded;
    var nonError = registered
        ? child(login, logout, errorMessage)
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
          ? const AnimationPage(
          asset: LottieAnimations.dogSwimming,
          text: "Error - Doggie can't swim")
          : nonError,
      // TODO: Add a theme
    );
  }
}
