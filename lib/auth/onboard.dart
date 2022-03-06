import 'package:coursecupid/auth/lib/user.dart';
import 'package:coursecupid/core/blank.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class OnboardPage extends StatefulWidget {
  final AuthMetaUser user;
  final VoidCallback refresh;

  const OnboardPage(this.user, this.refresh, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  final _form = FormGroup({
    'name': FormControl<String>(
        value: "", validators: [Validators.min(1), Validators.maxLength(64)]),
  });

  @override
  Widget build(BuildContext context) {
    return EmptyPage(children: [
      Text("Tell us your name!", style: Theme.of(context).textTheme.headline3),
      const SizedBox(height: 20),
      ReactiveTextField(
        decoration: const InputDecoration(filled: true, labelText: 'Name'),
        formControlName: 'name',
      ),
    ]);
  }
}
