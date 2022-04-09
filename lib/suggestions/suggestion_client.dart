import 'package:coursecupid/api_lib/swagger.swagger.dart';
import 'package:coursecupid/auth/lib/user.dart';
import 'package:coursecupid/core/resp_ext.dart';
import 'package:coursecupid/core/result_ext.dart';
import 'package:coursecupid/http_error.dart';
import 'package:coursecupid/suggestions/three_suggestion_widget.dart';
import 'package:coursecupid/suggestions/two_suggestion_widget.dart';
import 'package:flutter/cupertino.dart';

import '../core/api_service.dart';

class SuggestionResult<T> {
  final List<T> suggestions;
  final String connector;

  SuggestionResult(this.suggestions, this.connector);
}

abstract class SuggestionClient<T> {
  final ApiService api;
  final AuthMetaUser user;

  SuggestionClient(this.api, this.user);

  Future<Result<SuggestionResult<T>, HttpResponseError>> get(
      String? connectorId, int? take);

  Widget gen(Future<void> Function() refresh, T input);
}

class ThreeWaySuggestionClient
    extends SuggestionClient<ThreeWaySuggestionResp> {
  ThreeWaySuggestionClient(ApiService api, AuthMetaUser user)
      : super(api, user);

  @override
  Future<Result<SuggestionResult<ThreeWaySuggestionResp>, HttpResponseError>>
      get(String? connectorId, int? take) async {
    var r = await api.access.suggestionThreeGet(
      connectorId: connectorId,
      take: take,
    );
    return r.toResult().mapValue((value) =>
        SuggestionResult(value, value.isEmpty ? "" : (value.last.id ?? "")));
  }

  @override
  Widget gen(Future<void> Function() refresh, ThreeWaySuggestionResp input) {
    return ThreeWaySuggestionWidget(
      api: api,
      refresh: refresh,
      user: user,
      suggestion: input,
    );
  }
}

class TwoWaySuggestionClient extends SuggestionClient<TwoWaySuggestionResp> {
  TwoWaySuggestionClient(ApiService api, AuthMetaUser user) : super(api, user);

  @override
  Future<Result<SuggestionResult<TwoWaySuggestionResp>, HttpResponseError>> get(
      String? connectorId, int? take) async {
    var r = await api.access.suggestionTwoGet(
      connectorId: connectorId,
      take: take,
    );
    return r.toResult().mapValue((value) =>
        SuggestionResult(value, value.isEmpty ? "" : (value.last.id ?? "")));
  }

  @override
  Widget gen(Future<void> Function() refresh, TwoWaySuggestionResp input) {
    return TwoWaySuggestionWidget(
      api: api,
      refresh: refresh,
      user: user,
      suggestion: input,
    );
  }
}
