import 'package:package_info_plus/package_info_plus.dart';

class _RawEnvironment {
  final String _authDomain = const String.fromEnvironment('AUTH_DOMAIN');
  final String _authClientId = const String.fromEnvironment('AUTH_CLIENT_ID');
  final String _gitBranch = const String.fromEnvironment('GIT_BRANCH');
  final String _gitSha = const String.fromEnvironment('GIT_SHA');

  String? get authDomain => _authDomain.isEmpty ? null : _authDomain;

  String? get authClientId => _authClientId.isEmpty ? null : _authClientId;

  String? get gitBranch => _gitBranch.isEmpty ? null : _gitBranch;

  String? get gitSha => _gitBranch.isEmpty ? null : _gitSha;
}

class AppConfiguration {
  final String authDomain;
  final String authClientId;
  final String appName;
  final String packageName;
  final String version;
  final String buildNumber;
  final String buildSignature;
  final String auth0RedirectUri;
  final String auth0Issuer;
  final String gitBranch;
  final String gitSha;

  static AppConfiguration? _fromPlatform;

  AppConfiguration(
      this.authDomain,
      this.authClientId,
      this.appName,
      this.packageName,
      this.version,
      this.buildNumber,
      this.auth0RedirectUri,
      this.auth0Issuer,
      this.gitBranch,
      this.gitSha,
      [this.buildSignature = '']);

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
    final gitBranch = raw.gitBranch ?? "Unknown Branch";
    final gitSha = raw.gitSha ?? "Unknown SHA";

    final config = AppConfiguration(
      authDomain,
      authClientId,
      packageInfo.appName,
      packageInfo.packageName,
      packageInfo.version,
      packageInfo.buildNumber,
      "${packageInfo.packageName}://login-callback",
      "https://$authDomain}",
      gitBranch,
      gitSha,
      packageInfo.buildSignature,
    );
    _fromPlatform = config;
    return config;
  }
}
