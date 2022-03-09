import 'package:coursecupid/components/error_box.dart';
import 'package:coursecupid/http_error.dart';
import 'package:flutter/material.dart';

class ErrorPair {
  final String type;
  final String value;

  ErrorPair(this.type, this.value);
}

class ErrorDisplay extends StatefulWidget {
  final HttpResponseError error;

  const ErrorDisplay(this.error, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ErrorDisplayState();
}

class _ErrorDisplayState extends State<ErrorDisplay> {
  List<ErrorPair> errors = [];

  @override
  void initState() {
    final e = widget.error;

    if (e.errors == null || e.errors!.isEmpty) {
      errors = [ErrorPair(e.title, e.detail ?? e.type)];
    } else {
      for (var k in e.errors!.keys) {
        var v = e.errors![k];
        if (v != null) {
          for (var err in v) {
            errors.add(ErrorPair(k, err));
          }
        }
      }
    }
    super.initState();
  }

  remove(ErrorPair e) {
    setState(() {
      errors = errors.where((element) => element != e).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: errors
            .map((e) => InkWell(
                  child: ErrorBox(e.type, e.value),
                  onTap: () => remove(e),
                ))
            .toList());
  }
}
