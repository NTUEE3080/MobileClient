import 'package:chopper/chopper.dart';
import 'package:coursecupid/core/app_config.dart';
import 'package:coursecupid/auth/lib/auth0.dart';

import '../api_lib/swagger.swagger.dart';

class ApiService {
  final AppConfiguration config;
  final Auth0 auth;
  late Swagger access;

  static ApiService? _fromPlatform;

  static Future<ApiService> fromPlatform() async {
    if (_fromPlatform != null) {
      return _fromPlatform!;
    }

    var config = await AppConfiguration.fromPlatform();
    var auth = await Auth0.fromPlatform();
    var api = ApiService(config, auth);
    _fromPlatform = api;
    return api;
  }

  ApiService(this.config, this.auth) {
    access = Swagger.create(
      baseUrl: config.apiUrl,
      interceptors: [
        (Request request) async {
          var r = await auth.getAccessToken();
          if (r.isSuccess) {
            var v = r.value;
            if (v != null) {
              return applyHeader(request, 'authorization', "Bearer $v");
            }
          }
          return request;
        }
      ],
    );
  }
}
