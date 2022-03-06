// To parse this JSON data, do
//
//     final accessToken = accessTokenFromJson(jsonString);

import 'dart:convert';

AccessToken accessTokenFromJson(String str) => AccessToken.fromJson(json.decode(str));

String accessTokenToJson(AccessToken data) => json.encode(data.toJson());

class AccessToken {
  AccessToken({
    required this.iss,
    required this.sub,
    required this.aud,
    required this.iat,
    required this.exp,
    required this.scope,
  });

  String iss;
  String sub;
  List<String> aud;
  int iat;
  int exp;
  String scope;

  factory AccessToken.fromJson(Map<String, dynamic> json) => AccessToken(
    iss: json["iss"],
    sub: json["sub"],
    aud: List<String>.from(json["aud"].map((x) => x)),
    iat: json["iat"],
    exp: json["exp"],
    scope: json["scope"],
  );

  Map<String, dynamic> toJson() => {
    "iss": iss,
    "sub": sub,
    "aud": List<dynamic>.from(aud.map((x) => x)),
    "iat": iat,
    "exp": exp,
    "scope": scope,
  };
}
