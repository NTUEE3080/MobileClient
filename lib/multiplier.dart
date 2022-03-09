import 'dart:math';

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class Multiplier extends StatefulWidget {
  const Multiplier({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() => _MultiplierState();
}
class _MultiplierState extends State<Multiplier> {

  final _form = FormGroup({
    'base': FormControl<int>(value: 1, validators: [Validators.number]),
    'scale': FormControl<int>(value: 2, validators: [Validators.number]),
  });

  FormControl<int> get base => _form.control('base') as FormControl<int>;

  FormControl<int> get scale => _form.control('scale') as FormControl<int>;
  int _base = 1;
  int _scale = 2;

  _MultiplierState() {
    base.valueChanges.listen((val) => setState(() => _base = val ?? 1));
    scale.valueChanges.listen((val) => setState(() => _scale = val ?? 2));
  }

  int _count = 0;

  void _reset() {
    setState(() {
      _count = 0;
    });
  }

  void _scaleUp() {
    setState(() {
      _count++;
    });
  }

  void _scaleDown() {
    setState(() {
      _count--;
    });
  }

  @override
  Widget build(BuildContext context) {
    var keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const Text('Current Counter'),
                    Text(
                      '${_base * pow(_scale, _count)}',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: ReactiveForm(
                  formGroup: _form,
                  child: Column(
                    children: [
                      ReactiveTextField(
                        decoration: const InputDecoration(
                            filled: true, labelText: 'Base'),
                        formControlName: 'base',
                      ),
                      const SizedBox(height: 12.0),
                      ReactiveTextField(
                        decoration: const InputDecoration(
                            filled: true,
                            labelText: 'Scale'
                        ),
                        formControlName: 'scale',
                      ),
                    ],
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: _scaleUp,
                    child: const Text("Scale Up")),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.error,
                    ),
                    onPressed: _scaleDown,
                    child: const Text("Scale Down"))
              ],
            )
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: Visibility(
        visible: !keyboardIsOpen,
        child: FloatingActionButton(
          onPressed: _reset,
          tooltip: 'Reset',
          child: const Icon(Icons.restart_alt),
        ),
      ),
    );
  }
}
