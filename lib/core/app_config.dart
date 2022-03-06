import 'package:package_info_plus/package_info_plus.dart';

class _RawEnvironment {
  final String _authDomain = const String.fromEnvironment('AUTH_DOMAIN');
  final String _authClientId = const String.fromEnvironment('AUTH_CLIENT_ID');
  final String _authAudience = const String.fromEnvironment('AUTH_AUDIENCE');
  final String _gitBranch = const String.fromEnvironment('GIT_BRANCH');
  final String _gitSha = const String.fromEnvironment('GIT_SHA');
  final String _apiDomain = const String.fromEnvironment('API_DOMAIN');
  final String _apiScheme = const String.fromEnvironment('API_SCHEME');
  final String _apiPort = const String.fromEnvironment('API_PORT');

  String? get authDomain => _authDomain.isEmpty ? null : _authDomain;

  String? get authClientId => _authClientId.isEmpty ? null : _authClientId;

  String? get authAudience => _authAudience.isEmpty ? null : _authAudience;

  String? get gitBranch => _gitBranch.isEmpty ? null : _gitBranch;

  String? get gitSha => _gitBranch.isEmpty ? null : _gitSha;

  String? get apiDomain => _apiDomain.isEmpty ? null : _apiDomain;

  String? get apiScheme => _apiScheme.isEmpty ? null : _apiScheme;

  String? get apiPort => _apiPort.isEmpty ? null : _apiPort;

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

  AppConfiguration(
      this.authDomain,
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

  static Future<AppConfiguration> fromPlatform() async {
    if (_fromPlatform != null) {
      return _fromPlatform!;
    }
    final packageInfo = await PackageInfo.fromPlatform();
    final raw = _RawEnvironment();
    final authDomain = raw.authDomain ??
        (throw const FormatException("Auth Domain not defined"));
    final authClientId = raw.authClientId ??
        (throw const FormatException("Auth Client ID not defined"));
    final authAud = raw.authAudience ??
        (throw const FormatException("Auth Audience not defined"));
    final apiDomain = raw.apiDomain ??
        (throw const FormatException("API Domain not defined"));
    final scheme = raw.apiScheme ?? "https";
    final gitBranch = raw.gitBranch ?? "Unknown Branch";
    final gitSha = raw.gitSha ?? "Unknown SHA";
    final port = raw.apiPort == null ? "" : ":${raw.apiPort}";
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
      raw.apiScheme,
      raw.apiPort,
      packageInfo.buildSignature,
    );
    _fromPlatform = config;
    return config;
  }
}
