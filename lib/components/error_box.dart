import 'package:flutter/material.dart';

class ErrorBox extends StatelessWidget {
  final String type;
  final String value;

  const ErrorBox(this.type, this.value, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Text(
        "$type: $value",
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
      ),
      decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.error,
            width: 1,
          ),
          color: Theme.of(context).colorScheme.error.withAlpha(20),
          borderRadius: const BorderRadius.all(Radius.circular(12))),
    );
  }
}
