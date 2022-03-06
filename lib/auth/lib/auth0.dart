import 'dart:convert';

import 'package:coursecupid/auth/lib/access_token.dart';
import 'package:coursecupid/auth/lib/user.dart';
import 'package:coursecupid/core/app_config.dart';
import 'package:coursecupid/core/resp_ext.dart';
import 'package:coursecupid/core/result_ext.dart';
import 'package:coursecupid/swagger_generated_code/swagger.swagger.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

import '../../core/api_service.dart';
import 'auth_tokens.dart';
import 'id_token.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

bool isNtu(String s) {
  var frags = s.split("@");
  if (frags.length != 2) return false;
  var domain = frags[frags.length - 1];
  return domain == "e.ntu.edu.sg";
}

var nullMetaUserFuture = Future.value(Result<AuthMetaUser?, String>.ok(null));

final FlutterAppAuth appAuth = FlutterAppAuth();
const FlutterSecureStorage secureStorage = FlutterSecureStorage();

class Auth0 {
  final AppConfiguration config;

  const Auth0(this.config);

  static Auth0? _platformAuth0;

  static Future<Auth0> fromPlatform() async {
    if (_platformAuth0 != null) {
      return _platformAuth0!;
    }
    final config = await AppConfiguration.fromPlatform();
    var user = AuthMetaUser(false, false, false, false, null);
    final auth0 = Auth0(config);
    _platformAuth0 = auth0;
    return auth0;
  }

  IdToken _parseIdToken(String idToken) {
    final parts = idToken.split(r'.');
    assert(parts.length == 3);
    return idTokenFromJson(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
  }

  AccessToken _parseAccessToken(String accessToken) {
    final parts = accessToken.split(r'.');
    assert(parts.length == 3);
    return accessTokenFromJson(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
  }

  Result<AuthTokens, String> _parseTokenResponse(TokenResponse? r) {
    if (r == null) return Result.error("Null result from Auth endpoint");
    if (r.idToken == null) return Result.error("No ID token obtained");
    if (r.accessToken == null) return Result.error("No access token obtained");
    if (r.refreshToken == null) {
      return Result.error("No refresh token obtained");
    }
    final idToken = _parseIdToken(r.idToken!);
    logger.i(idToken);
    return Result.ok(AuthTokens(idToken, r.accessToken!, r.refreshToken!));
  }

  Future<Result<AuthUserData?, String>> _getUserData(String token) async {
    var api = await ApiService.fromPlatform();
    var resp = await api.access.userSelfGet();

    return resp
        .toResult()
        .mapValue((value) => value as UserPrincipalResp?)
        .thenError((error) {
          if (error.type == "PitaPairing.Errors.NotFoundError") {
            return Result.ok(null);
          }
          return Result.error(error);
        })
        .mapError((error) => error.title)
        .mapValue((value) => value == null
            ? null
            : AuthUserData(value.id!, value.name!, value.email!, null));
  }

  Future<AuthMetaUser> logout() async {
    await secureStorage.delete(key: 'refresh_token');
    return AuthMetaUser(false, false, false, false, null);
  }

  Future<Result<AuthMetaUser, String>> login() async {
    return await getToken().andThenAsync((t) => _getUserData(t.accessToken)
        .thenMap((value) => AuthMetaUser(true, isNtu(t.idToken.email),
            t.idToken.emailVerified, value == null, value)));
  }

  Future<AuthMetaUser?> refreshSession() async {
    var r1 = await refreshToken();
    logger.d("r1: $r1");
    var result = await r1.thenAsync<AuthMetaUser?>((t) {
      logger.d("t: $t");
      if (t == null) {
        return nullMetaUserFuture;
      } else {
        return _getUserData(t.accessToken).thenMap((value) => AuthMetaUser(
            true,
            isNtu(t.idToken.email),
            t.idToken.emailVerified,
            value == null,
            value));
      }
    });

    return result.getValueOrElse(() => null);
  }

  Future<Result<String?, String>> getAccessToken() async {
    final storedAccessToken =
        await secureStorage.read(key: 'auth0_access_token');
    if (storedAccessToken != null) {
      var r = _parseAccessToken(storedAccessToken);
      if (DateTime.fromMillisecondsSinceEpoch(r.exp * 1000)
          .isBefore(DateTime.now())) {
        return Result.ok(storedAccessToken);
      }
    }
    return await refreshToken().thenMap((value) => value?.accessToken);
  }

  Future<Result<AuthTokens?, String>> refreshToken() async {
    final storedRefreshToken =
        await secureStorage.read(key: 'auth0_refresh_token');
    if (storedRefreshToken == null) {
      return Result.ok(null);
    }
    try {
      final r = await appAuth.token(TokenRequest(
        config.authClientId,
        config.auth0RedirectUri,
        issuer: 'https://${config.authDomain}',
        refreshToken: storedRefreshToken,
        scopes: ['openid', 'profile', 'offline_access', 'email'],
        additionalParameters: {
          'audience': config.authAudience,
        },
      ));

      return _parseTokenResponse(r).runAsync((r) async {
        await secureStorage.write(
            key: 'auth0_refresh_token', value: r.refreshToken);
        await secureStorage.write(
            key: 'auth0_access_token', value: r.accessToken);
      });
    } catch (e, s) {
      logger.e('login error: $e - stack: $s');
      return Result.error(e.toString());
    }
  }

  Future<Result<AuthTokens, String>> getToken() async {
    try {
      final AuthorizationTokenResponse? r =
          await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(config.authClientId, config.auth0RedirectUri,
            additionalParameters: {
              'audience': config.authAudience,
            },
            issuer: 'https://${config.authDomain}',
            scopes: ['openid', 'profile', 'offline_access', 'email'],
            promptValues: ['login']),
      );
      return _parseTokenResponse(r).runAsync((r) async {
        await secureStorage.write(
            key: 'auth0_refresh_token', value: r.refreshToken);
        await secureStorage.write(
            key: 'auth0_access_token', value: r.accessToken);
      });
    } catch (e, s) {
      logger.e('login error: $e - stack: $s');
      return Result.error(e.toString());
    }
  }
}
