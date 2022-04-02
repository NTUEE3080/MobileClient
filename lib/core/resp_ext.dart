import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:coursecupid/core/result_ext.dart';
import 'package:coursecupid/http_error.dart';

extension StringExt on String {
  bool lowerCompare(String? other) {
    if ( other == null) return false;
    var tLower = toLowerCase();
    var oLower = other.toLowerCase();
    return tLower.contains(oLower) || oLower.contains(tLower);
  }
}

extension ResponseExt<T> on Response<T> {
  Result<T, HttpResponseError> toResult() {
    if (isSuccessful) {
      return Result.ok(this.body as T);
    } else {
      if (error is String) {
        var e = error as String;
        return Result.error(HttpResponseError.fromJson(jsonDecode(e)));
      } else {
        var e = HttpResponseError(
            type: "UnknownError",
            title: "Client side cannot parse error response",
            detail: "Client side cannot parse error response",
            instance: "none",
            status: 500,
            traceId: "none");
        return Result.error(e);
      }
    }
  }
}
