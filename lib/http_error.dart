// To parse this JSON data, do
//
//     final httpResponseError = httpResponseErrorFromJson(jsonString);

import 'dart:convert';

HttpResponseError httpResponseErrorFromJson(String str) =>
    HttpResponseError.fromJson(json.decode(str));

String httpResponseErrorToJson(HttpResponseError data) =>
    json.encode(data.toJson());

const noOpError = <String, List<String>>{};

class HttpResponseError {
  HttpResponseError({
    required this.type,
    required this.title,
    required this.status,
    required this.traceId,
    required this.instance,
    required this.detail,
    this.errors = noOpError,
  });

  String type;
  String title;
  int status;
  String traceId;
  String? instance;
  String? detail;
  Map<String, List<String>>? errors;

  factory HttpResponseError.fromJson(Map<String, dynamic> j) {
    var noOpMap = <String, dynamic>{};
    var errorMap = j["errors"] as Map<String, dynamic>? ?? noOpMap;

    return HttpResponseError(
      type: j["type"],
      title: j["title"],
      status: j["status"],
      traceId: j["traceId"],
      instance: j["instance"],
      detail: j["detail"],
      errors: errorMap.map((key, value) =>
          MapEntry(key as String, value as List<String>)
              as MapEntry<String, List<String>>),
    );
  }

  Map<String, dynamic> toJson() => {
        "type": type,
        "title": title,
        "status": status,
        "traceId": traceId,
        "instance": instance,
        "detail": detail,
        "errors": errors,
      };
}
