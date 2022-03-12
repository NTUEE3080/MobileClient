import 'package:coursecupid/core/result_ext.dart';
import 'package:coursecupid/http_error.dart';
import 'package:flutter/material.dart';

class FutureRefreshableWidget<T> extends StatelessWidget {
  final Future<Result<T, HttpResponseError>> Function() load;
  final Widget Function(Future<void> Function() refresh, T t) child;
  final Widget loadingScreen;
  final Widget errorScreen;

  const FutureRefreshableWidget(
      {Key? key,
      required this.load,
      required this.loadingScreen,
      required this.errorScreen,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Result<T, HttpResponseError>>(
        future: load(),
        builder: (context, val) {
          if (val.connectionState == ConnectionState.done) {
            if (val.hasData) {
              var v = val.data!;
              if (v.isSuccess) {
                return RefreshableWidget(
                  child: child,
                  load: load,
                  value: v.value,
                );
              }
            }
            return errorScreen;
          }
          return loadingScreen;
        });
  }
}

class RefreshableWidget<T> extends StatefulWidget {
  final Future<Result<T, HttpResponseError>> Function() load;
  final Widget Function(Future<void> Function() refresh, T value) child;
  final T value;

  const RefreshableWidget(
      {Key? key, required this.load, required this.child, required this.value})
      : super(key: key);

  @override
  State<RefreshableWidget<T>> createState() => _RefreshableWidgetState<T>();
}

class _RefreshableWidgetState<T> extends State<RefreshableWidget<T>> {
  late T value;

  @override
  initState() {
    value = widget.value;
    super.initState();
  }

  Future<void> _refresh() async {
    var r = await widget.load();
    if (r.isSuccess) {
      setState(() => value = r.value);
    } else {
      final snackBar = SnackBar(
        content: const Text('Failed to refresh'),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child(_refresh, value);
  }
}
