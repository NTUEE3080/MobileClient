

import 'dart:convert';

import 'package:coursecupid/core/animation.dart';
import 'package:coursecupid/core/err_expandable.dart';
import 'package:coursecupid/http_error.dart';
import 'package:flutter/material.dart';

class ErrorAnimationFrame extends AnimationFrame {
  ErrorAnimationFrame({Key? key, required String asset, required String text, required String errTitle, required String errDetails}) : super(key: key, asset: asset, text: text, widgets: [const SizedBox(height: 20), ErrorViewer(errorTitle: errTitle, details: errDetails)]);
}

class ErrorAnimationPage extends AnimationPage {
  ErrorAnimationPage({Key? key, required String asset, required String text, required String errTitle, required String errDetails}) : super(key: key, asset: asset, text: text, widgets: [const SizedBox(height: 20), ErrorViewer(errorTitle: errTitle, details: errDetails)]);
}


class ExceptionAnimationFrame extends ErrorAnimationFrame {
  ExceptionAnimationFrame({Key? key, required String asset, required String text, Exception? e, StackTrace? st}) : super(key: key, asset: asset, text: text, errTitle: e?.toString() ?? "Unknown Exception", errDetails: st?.toString() ?? "Unknown Stacktrace");
}

class ExceptionAnimationPage extends ErrorAnimationPage {
  ExceptionAnimationPage({Key? key, required String asset, required String text, Exception? e, StackTrace? st}) : super(key: key, asset: asset, text: text, errTitle: e?.toString() ?? "Unknown Exception", errDetails: st?.toString() ?? "Unknown Stacktrace");
}


class HttpErrorAnimationFrame extends ErrorAnimationFrame {
  HttpErrorAnimationFrame({Key? key, required String asset, required String text, HttpResponseError? e}) : super(key: key, asset: asset, text: text, errTitle: e?.title ?? "Unknown Error", errDetails: jsonEncode(e));
}

class HttpErrorAnimationPage extends ErrorAnimationPage {
  HttpErrorAnimationPage({Key? key, required String asset, required String text, HttpResponseError? e}) : super(key: key, asset: asset, text: text, errTitle: e?.title ?? "Unknown Error", errDetails: jsonEncode(e));
}

