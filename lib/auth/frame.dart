import 'package:coursecupid/auth/initial.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'lib/Auth0.dart';
import 'lib/User.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

typedef Logout = Future<void> Function();
typedef Login = Future<void> Function();

class AuthFrame extends StatefulWidget {
  final Widget Function(Login login, Logout logout, String message) child;

  const AuthFrame({Key? key, required this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AuthFrameState();
}

Widget noOp(login, logout, message) {
  return const Center();
}

class _AuthFrameState extends State<AuthFrame> {
  Widget Function(Login login, Logout logout, String message) child = noOp;
  bool isBusy = false;
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

  updateError(String error) => setState(() => errorMessage = error);

  updateUser(AuthMetaUser? r) => setState(
      () => user = r ?? AuthMetaUser(false, false, false, false, null));

  Future<void> initAction() async {
    setBusy();
    var auth = await Auth0.fromPlatform();
    logger.i("start refresh session");
    var user = await auth.refreshSession();
    logger.i(user);
    logger.i("complete refresh session");
    updateUser(user);
    setFree();
  }

  Future<void> login() async {
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
  }

  Future<void> logout() async {
    setBusy();
    var auth = await Auth0.fromPlatform();
    var r = await auth.logout();
    updateUser(r);
    updateError("");
    setFree();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Course Cupid',
        home: user.loggedIn && user.emailVerified && user.emailFromNTU
            ? child(login, logout, errorMessage)
            : InitialPage(
                refresh: initAction,
                user: user,
                loginAction: login,
                logoutAction: logout,
                loginError: errorMessage,
                busy: isBusy,
              )
        // TODO: Add a theme
        );
  }
}
