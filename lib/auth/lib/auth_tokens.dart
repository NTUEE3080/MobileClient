import 'package:coursecupid/auth/lib/id_token.dart';

class AuthTokens {
  final IdToken idToken;
  final String accessToken;
  final String refreshToken;

  const AuthTokens(this.idToken, this.accessToken, this.refreshToken);
}