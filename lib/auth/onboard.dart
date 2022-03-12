import 'package:coursecupid/auth/lib/user.dart';
import 'package:coursecupid/core/animation.dart';
import 'package:coursecupid/core/resp_ext.dart';
import 'package:coursecupid/http_error.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../api_lib/swagger.swagger.dart';
import '../components/error_renderer.dart';
import '../core/api_service.dart';

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
        value: "",
        validators: [Validators.minLength(1), Validators.maxLength(24)]),
  });

  HttpResponseError? validationError;
  bool loading = false;

  setError(HttpResponseError e) {
    setState(() => validationError = e);
  }

  busy() => setState(() => loading = true);

  free() => setState(() => loading = false);

  _onSubmit() async {
    busy();
    var apiService = await ApiService.fromPlatform();
    var resp = await apiService.access.userPost(
        body: CreateUserReq(
      email: widget.user.tokenData?.email,
      name: _form.value['name'] as String? ?? "",
    ));
    resp.toResult().match(onSuccess: (s) async {
      await Future.delayed(const Duration(seconds: 2));
      free();
      widget.refresh();
    }, onError: (e) {
      free();
      return setError(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    var e = validationError != null
        ? ErrorDisplay(validationError!)
        : const SizedBox(height: 4);
    var form = Container(
      padding: const EdgeInsets.all(16),
      child: ReactiveForm(
          formGroup: _form,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              e,
              const SizedBox(height: 40),
              Text("Tell us your name!",
                  style: Theme.of(context).textTheme.headline6),
              const SizedBox(height: 40),
              ReactiveTextField(
                decoration:
                    const InputDecoration(filled: true, labelText: 'Name'),
                formControlName: 'name',
              ),
              ReactiveFormConsumer(
                builder: (context, form, child) {
                  return ElevatedButton(
                    child: const Text('Next'),
                    onPressed: form.valid ? _onSubmit : null,
                  );
                },
              ),
            ],
          )),
    );

    var registering = const AnimationPage(
        asset: LottieAnimations.register, text: "Registering...");

    return Scaffold(
      body: SafeArea(
        child: loading ? registering : form,
      ),
    );
  }
}
