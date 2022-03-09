import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:coursecupid/core/result_ext.dart';
import 'package:coursecupid/http_error.dart';

extension ResponseExt<T> on Response<T> {
  Result<T, HttpResponseError> toResult() {
    if (isSuccessful) {
      return Result.ok(this.body as T);
    } else {
      logger.i(error.runtimeType);
      logger.i(error.toString());
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
