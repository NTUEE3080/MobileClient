import 'package:coursecupid/auth/lib/IdkToken.dart';

class AuthTokens {
  final IdToken idToken;
  final String accessToken;
  final String refreshToken;

  const AuthTokens(this.idToken, this.accessToken, this.refreshToken);
}