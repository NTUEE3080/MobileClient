// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'swagger.swagger.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$Swagger extends Swagger {
  _$Swagger([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = Swagger;

  @override
  Future<Response<List<ApplicationRes>>> _applicationGet(
      {String? posterId, String? applierId, String? status}) {
    final $url = '/Application';
    final $params = <String, dynamic>{
      'posterId': posterId,
      'applierId': applierId,
      'status': status
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<List<ApplicationRes>, ApplicationRes>($request);
  }

  @override
  Future<Response<dynamic>> _applicationPostIdAppIdPost(
      {required String? postId, required String? appId}) {
    final $url = '/Application/${postId}/${appId}';
    final $request = Request('POST', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<IndexRes>>> _indexGet(
      {String? semester, String? course, String? day, String? venue}) {
    final $url = '/Index';
    final $params = <String, dynamic>{
      'semester': semester,
      'course': course,
      'day': day,
      'venue': venue
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<List<IndexRes>, IndexRes>($request);
  }

  @override
  Future<Response<dynamic>> _indexPost({required List<CreateIndexReq>? body}) {
    final $url = '/Index';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<IndexRes>> _indexIdGet({required String? id}) {
    final $url = '/Index/${id}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<IndexRes, IndexRes>($request);
  }

  @override
  Future<Response<List<ModulePrincipalRes>>> _moduleGet({String? semester}) {
    final $url = '/Module';
    final $params = <String, dynamic>{'semester': semester};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<List<ModulePrincipalRes>, ModulePrincipalRes>($request);
  }

  @override
  Future<Response<dynamic>> _modulePost(
      {required List<CreateModuleReq>? body}) {
    final $url = '/Module';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<ModuleRes>> _moduleIdGet({required String? id}) {
    final $url = '/Module/${id}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<ModuleRes, ModuleRes>($request);
  }

  @override
  Future<Response<List<PostPrincipalResp>>> _postGet(
      {String? semester,
      String? curateFor,
      String? posterId,
      String? moduleId,
      String? indexId,
      String? lookId,
      bool? completed}) {
    final $url = '/Post';
    final $params = <String, dynamic>{
      'semester': semester,
      'curateFor': curateFor,
      'posterId': posterId,
      'moduleId': moduleId,
      'indexId': indexId,
      'lookId': lookId,
      'completed': completed
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<List<PostPrincipalResp>, PostPrincipalResp>($request);
  }

  @override
  Future<Response<dynamic>> _postPost({required CreatePostReq? body}) {
    final $url = '/Post';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<PostResp>> _postIdGet({required String? id}) {
    final $url = '/Post/${id}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<PostResp, PostResp>($request);
  }

  @override
  Future<Response<dynamic>> _postIdDelete({required String? id}) {
    final $url = '/Post/${id}';
    final $request = Request('DELETE', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _postRejectPostIdAppIdPost(
      {required String? postId, required String? appId}) {
    final $url = '/Post/reject/${postId}/${appId}';
    final $request = Request('POST', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _postAcceptPostIdAppIdPost(
      {required String? postId, required String? appId}) {
    final $url = '/Post/accept/${postId}/${appId}';
    final $request = Request('POST', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<SemesterRes>>> _semesterGet() {
    final $url = '/Semester';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<SemesterRes>, SemesterRes>($request);
  }

  @override
  Future<Response<SemesterRes>> _semesterPost(
      {required CreateSemesterReq? body}) {
    final $url = '/Semester';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<SemesterRes, SemesterRes>($request);
  }

  @override
  Future<Response<dynamic>> _semesterCurrentPost(
      {required CreateSemesterReq? body}) {
    final $url = '/Semester/current';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<String>> _currentGet() {
    final $url = '/current';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<String, String>($request);
  }

  @override
  Future<Response<List<TwoWaySuggestionResp>>> _suggestionAdminTwoUserIdGet(
      {required String? userId, String? connectorId, int? take}) {
    final $url = '/Suggestion/admin/two/${userId}';
    final $params = <String, dynamic>{'connectorId': connectorId, 'take': take};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client
        .send<List<TwoWaySuggestionResp>, TwoWaySuggestionResp>($request);
  }

  @override
  Future<Response<List<ThreeWaySuggestionResp>>> _suggestionAdminThreeUserIdGet(
      {required String? userId, String? connectorId, int? take}) {
    final $url = '/Suggestion/admin/three/${userId}';
    final $params = <String, dynamic>{'connectorId': connectorId, 'take': take};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client
        .send<List<ThreeWaySuggestionResp>, ThreeWaySuggestionResp>($request);
  }

  @override
  Future<Response<List<TwoWaySuggestionResp>>> _suggestionTwoGet(
      {String? connectorId, int? take}) {
    final $url = '/Suggestion/two';
    final $params = <String, dynamic>{'connectorId': connectorId, 'take': take};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client
        .send<List<TwoWaySuggestionResp>, TwoWaySuggestionResp>($request);
  }

  @override
  Future<Response<List<ThreeWaySuggestionResp>>> _suggestionThreeGet(
      {String? connectorId, int? take}) {
    final $url = '/Suggestion/three';
    final $params = <String, dynamic>{'connectorId': connectorId, 'take': take};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client
        .send<List<ThreeWaySuggestionResp>, ThreeWaySuggestionResp>($request);
  }

  @override
  Future<Response<dynamic>> _suggestionAddSourceGet({required String? source}) {
    final $url = '/Suggestion/add/${source}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _suggestionSearchSourceGet(
      {required String? source}) {
    final $url = '/Suggestion/search/${source}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<UserPrincipalResp>>> _userGet() {
    final $url = '/User';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<UserPrincipalResp>, UserPrincipalResp>($request);
  }

  @override
  Future<Response<UserPrincipalResp>> _userPost(
      {required CreateUserReq? body}) {
    final $url = '/User';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<UserPrincipalResp, UserPrincipalResp>($request);
  }

  @override
  Future<Response<UserPrincipalResp>> _userSelfGet() {
    final $url = '/User/self';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<UserPrincipalResp, UserPrincipalResp>($request);
  }

  @override
  Future<Response<UserPrincipalResp>> _userIdGet({required String? id}) {
    final $url = '/User/${id}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<UserPrincipalResp, UserPrincipalResp>($request);
  }

  @override
  Future<Response<UserPrincipalResp>> _userIdPut(
      {required String? id, required UpdateUserReq? body}) {
    final $url = '/User/${id}';
    final $body = body;
    final $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<UserPrincipalResp, UserPrincipalResp>($request);
  }

  @override
  Future<Response<dynamic>> _userIdDelete({required String? id}) {
    final $url = '/User/${id}';
    final $request = Request('DELETE', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
