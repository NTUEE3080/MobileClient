import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

class _JSONConfig {
  final String? _authDomain;
  final String? _authClientId;
  final String? _authAudience;
  final String? _gitBranch;
  final String? _gitSha;
  final String? _apiDomain;
  final String? _apiScheme;
  final String? _apiPort;

  _JSONConfig(
      this._authDomain,
      this._authClientId,
      this._authAudience,
      this._gitBranch,
      this._gitSha,
      this._apiDomain,
      this._apiScheme,
      this._apiPort);
}

class _ConfigReader {
  static final Map<String, _JSONConfig> _configs = {};

  static Future<_JSONConfig> fromPlatform(String env) async {
    if (_configs[env] != null) return _configs[env]!;

    final configString = await rootBundle.loadString('env/$env.json');
    var _config = json.decode(configString) as Map<String, dynamic>;
    var config = _JSONConfig(
      _config["AUTH_DOMAIN"],
      _config["AUTH_CLIENT_ID"],
      _config["AUTH_AUDIENCE"],
      _config["GIT_BRANCH"],
      _config["GIT_SHA"],
      _config["API_DOMAIN"],
      _config["SCHEME"],
      _config["PORT"],
    );
    _configs[env] = config;
    return config;
  }
}

class _RawEnvironment {
  final String _appEnv = const String.fromEnvironment("APP_ENV");

  String get appEnv => _appEnv == "" ? "dev" : _appEnv;
}

class AppConfiguration {
  final String authDomain;
  final String authClientId;
  final String authAudience;
  final String appName;
  final String packageName;
  final String version;
  final String buildNumber;
  final String buildSignature;
  final String auth0RedirectUri;
  final String auth0Issuer;
  final String gitBranch;
  final String gitSha;
  final String apiUrl;
  final String apiDomain;
  final String? apiScheme;
  final String? apiPort;

  static AppConfiguration? _fromPlatform;
  static AppConfiguration? _fromPlatformErrorless;

  AppConfiguration(this.authDomain,
      this.authClientId,
      this.authAudience,
      this.appName,
      this.packageName,
      this.version,
      this.buildNumber,
      this.auth0RedirectUri,
      this.auth0Issuer,
      this.gitBranch,
      this.gitSha,
      this.apiUrl,
      this.apiDomain,
      this.apiScheme,
      this.apiPort,
      this.buildSignature);

  static Future<AppConfiguration> fromPlatformErrorless() async {
    if (_fromPlatformErrorless != null) {
      return _fromPlatformErrorless!;
    }
    final packageInfo = await PackageInfo.fromPlatform();
    final raw = _RawEnvironment();

    var c = await _ConfigReader.fromPlatform(raw._appEnv);

    final authDomain = c._authDomain ?? "";
    final authClientId = c._authClientId ?? "";
    final authAud = c._authAudience ?? "";
    final apiDomain = c._apiDomain ?? "";

    final scheme = c._apiScheme ?? "https";
    final gitBranch = c._gitBranch ?? "Unknown Branch";
    final gitSha = c._gitSha ?? "Unknown SHA";
    final port = c._apiPort == null ? "" : ":${c._apiPort}";

    final apiUrl = "$scheme://$apiDomain$port";

    final config = AppConfiguration(
      authDomain,
      authClientId,
      "https://$authAud",
      packageInfo.appName,
      packageInfo.packageName,
      packageInfo.version,
      packageInfo.buildNumber,
      "${packageInfo.packageName}://login-callback",
      "https://$authDomain}",
      gitBranch,
      gitSha,
      apiUrl,
      apiDomain,
      c._apiScheme ?? "",
      c._apiPort ?? "",
      packageInfo.buildSignature,
    );
    _fromPlatformErrorless = config;
    return config;
  }

  static Future<AppConfiguration> fromPlatform() async {
    if (_fromPlatform != null) {
      return _fromPlatform!;
    }
    final packageInfo = await PackageInfo.fromPlatform();
    final raw = _RawEnvironment();

    var c = await _ConfigReader.fromPlatform(raw._appEnv);

    final authDomain = c._authDomain ??
        (throw const FormatException("Auth Domain not defined"));
    final authClientId = c._authClientId ??
        (throw const FormatException("Auth Client ID not defined"));
    final authAud = c._authAudience ??
        (throw const FormatException("Auth Audience not defined"));
    final apiDomain =
        c._apiDomain ?? (throw const FormatException("API Domain not defined"));
    final scheme = c._apiScheme ?? "https";
    final gitBranch = c._gitBranch ?? "Unknown Branch";
    final gitSha = c._gitSha ?? "Unknown SHA";
    final port = c._apiPort == null ? "" : ":${c._apiPort}";
    final apiUrl = "$scheme://$apiDomain$port";

    final config = AppConfiguration(
      authDomain,
      authClientId,
      "https://$authAud",
      packageInfo.appName,
      packageInfo.packageName,
      packageInfo.version,
      packageInfo.buildNumber,
      "${packageInfo.packageName}://login-callback",
      "https://$authDomain}",
      gitBranch,
      gitSha,
      apiUrl,
      apiDomain,
      c._apiScheme ?? "",
      c._apiPort ?? "",
      packageInfo.buildSignature,
    );
    _fromPlatform = config;
    return config;
  }
}
