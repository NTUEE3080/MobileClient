import 'dart:convert';

IdToken idTokenFromJson(String str) => IdToken.fromJson(json.decode(str));

String idTokenToJson(IdToken data) => json.encode(data.toJson());

class IdToken {
  IdToken({
    required this.nickname,
    required this.name,
    required this.picture,
    required this.updatedAt,
    required this.email,
    required this.emailVerified,
    required this.iss,
    required this.sub,
    required this.aud,
    required this.iat,
    required this.exp,
    required this.authTime,
  });

  final String nickname;
  final String name;
  final String picture;
  final DateTime updatedAt;
  final String email;
  final bool emailVerified;
  final String iss;
  final String sub;
  final String aud;
  final int iat;
  final int exp;
  final int authTime;

  factory IdToken.fromJson(Map<String, dynamic> json) => IdToken(
    nickname: json["nickname"],
    name: json["name"],
    picture: json["picture"],
    updatedAt: DateTime.parse(json["updated_at"]),
    email: json["email"],
    emailVerified: json["email_verified"],
    iss: json["iss"],
    sub: json["sub"],
    aud: json["aud"],
    iat: json["iat"],
    exp: json["exp"],
    authTime: json["auth_time"],
  );

  Map<String, dynamic> toJson() => {
    "nickname": nickname,
    "name": name,
    "picture": picture,
    "updated_at": updatedAt.toIso8601String(),
    "email": email,
    "email_verified": emailVerified,
    "iss": iss,
    "sub": sub,
    "aud": aud,
    "iat": iat,
    "exp": exp,
    "auth_time": authTime,
  };
}
