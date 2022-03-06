// To parse this JSON data, do
//
//     final httpResponseError = httpResponseErrorFromJson(jsonString);

import 'dart:convert';

HttpResponseError httpResponseErrorFromJson(String str) =>
    HttpResponseError.fromJson(json.decode(str));

String httpResponseErrorToJson(HttpResponseError data) =>
    json.encode(data.toJson());

class HttpResponseError {
  HttpResponseError({
    required this.type,
    required this.title,
    required this.status,
    required this.traceId,
  });

  String type;
  String title;
  int status;
  String traceId;

  factory HttpResponseError.fromJson(Map<String, dynamic> json) =>
      HttpResponseError(
        type: json["type"],
        title: json["title"],
        status: json["status"],
        traceId: json["traceId"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "title": title,
        "status": status,
        "traceId": traceId,
      };
}
