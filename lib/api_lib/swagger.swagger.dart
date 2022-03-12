// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';

import 'package:chopper/chopper.dart';
import 'dart:convert';

import 'client_mapping.dart';
import 'package:chopper/chopper.dart' as chopper;

part 'swagger.swagger.chopper.dart';
part 'swagger.swagger.g.dart';

// **************************************************************************
// SwaggerChopperGenerator
// **************************************************************************

@ChopperApi()
abstract class Swagger extends ChopperService {
  static Swagger create(
      {ChopperClient? client,
      String? baseUrl,
      Iterable<dynamic>? interceptors}) {
    if (client != null) {
      return _$Swagger(client);
    }

    final newClient = ChopperClient(
        services: [_$Swagger()],
        converter: $JsonSerializableConverter(),
        interceptors: interceptors ?? [],
        baseUrl: baseUrl ?? 'http://');
    return _$Swagger(newClient);
  }

  ///
  ///@param moduleId
  ///@param indexId
  ///@param postId
  ///@param applierId
  ///@param accepterId
  Future<chopper.Response<List<ApplicationPrincipalRes>>> applicationGet(
      {String? moduleId,
      String? indexId,
      String? postId,
      String? applierId,
      String? accepterId}) {
    generatedMapping.putIfAbsent(
        ApplicationPrincipalRes, () => ApplicationPrincipalRes.fromJsonFactory);

    return _applicationGet(
        moduleId: moduleId,
        indexId: indexId,
        postId: postId,
        applierId: applierId,
        accepterId: accepterId);
  }

  ///
  ///@param moduleId
  ///@param indexId
  ///@param postId
  ///@param applierId
  ///@param accepterId
  @Get(path: '/Application')
  Future<chopper.Response<List<ApplicationPrincipalRes>>> _applicationGet(
      {@Query('moduleId') String? moduleId,
      @Query('indexId') String? indexId,
      @Query('postId') String? postId,
      @Query('applierId') String? applierId,
      @Query('accepterId') String? accepterId});

  ///
  ///@param moduleId
  ///@param indexId
  ///@param postId
  ///@param applierId
  ///@param accepterId
  Future<chopper.Response<List<ApplicationRes>>> applicationFullGet(
      {String? moduleId,
      String? indexId,
      String? postId,
      String? applierId,
      String? accepterId}) {
    generatedMapping.putIfAbsent(
        ApplicationRes, () => ApplicationRes.fromJsonFactory);

    return _applicationFullGet(
        moduleId: moduleId,
        indexId: indexId,
        postId: postId,
        applierId: applierId,
        accepterId: accepterId);
  }

  ///
  ///@param moduleId
  ///@param indexId
  ///@param postId
  ///@param applierId
  ///@param accepterId
  @Get(path: '/Application/full')
  Future<chopper.Response<List<ApplicationRes>>> _applicationFullGet(
      {@Query('moduleId') String? moduleId,
      @Query('indexId') String? indexId,
      @Query('postId') String? postId,
      @Query('applierId') String? applierId,
      @Query('accepterId') String? accepterId});

  ///
  ///@param id
  Future<chopper.Response<ApplicationRes>> applicationIdGet(
      {required String? id}) {
    generatedMapping.putIfAbsent(
        ApplicationRes, () => ApplicationRes.fromJsonFactory);

    return _applicationIdGet(id: id);
  }

  ///
  ///@param id
  @Get(path: '/Application/{id}')
  Future<chopper.Response<ApplicationRes>> _applicationIdGet(
      {@Path('id') required String? id});

  ///
  ///@param id
  Future<chopper.Response> applicationIdDelete({required String? id}) {
    return _applicationIdDelete(id: id);
  }

  ///
  ///@param id
  @Delete(path: '/Application/{id}')
  Future<chopper.Response> _applicationIdDelete(
      {@Path('id') required String? id});

  ///
  ///@param postId
  Future<chopper.Response> applicationPostIdPost(
      {required String? postId, required CreateApplicationReq? body}) {
    return _applicationPostIdPost(postId: postId, body: body);
  }

  ///
  ///@param postId
  @Post(path: '/Application/{postId}')
  Future<chopper.Response> _applicationPostIdPost(
      {@Path('postId') required String? postId,
      @Body() required CreateApplicationReq? body});

  ///
  ///@param semester
  ///@param course
  ///@param day
  ///@param venue
  Future<chopper.Response<List<IndexRes>>> indexGet(
      {String? semester, String? course, String? day, String? venue}) {
    generatedMapping.putIfAbsent(IndexRes, () => IndexRes.fromJsonFactory);

    return _indexGet(
        semester: semester, course: course, day: day, venue: venue);
  }

  ///
  ///@param semester
  ///@param course
  ///@param day
  ///@param venue
  @Get(path: '/Index')
  Future<chopper.Response<List<IndexRes>>> _indexGet(
      {@Query('semester') String? semester,
      @Query('course') String? course,
      @Query('day') String? day,
      @Query('venue') String? venue});

  ///
  Future<chopper.Response> indexPost({required List<CreateIndexReq>? body}) {
    return _indexPost(body: body);
  }

  ///
  @Post(path: '/Index')
  Future<chopper.Response> _indexPost(
      {@Body() required List<CreateIndexReq>? body});

  ///
  ///@param id
  Future<chopper.Response<IndexRes>> indexIdGet({required String? id}) {
    generatedMapping.putIfAbsent(IndexRes, () => IndexRes.fromJsonFactory);

    return _indexIdGet(id: id);
  }

  ///
  ///@param id
  @Get(path: '/Index/{id}')
  Future<chopper.Response<IndexRes>> _indexIdGet(
      {@Path('id') required String? id});

  ///
  ///@param semester
  Future<chopper.Response<List<ModulePrincipalRes>>> moduleGet(
      {String? semester}) {
    generatedMapping.putIfAbsent(
        ModulePrincipalRes, () => ModulePrincipalRes.fromJsonFactory);

    return _moduleGet(semester: semester);
  }

  ///
  ///@param semester
  @Get(path: '/Module')
  Future<chopper.Response<List<ModulePrincipalRes>>> _moduleGet(
      {@Query('semester') String? semester});

  ///
  Future<chopper.Response> modulePost({required List<CreateModuleReq>? body}) {
    return _modulePost(body: body);
  }

  ///
  @Post(path: '/Module')
  Future<chopper.Response> _modulePost(
      {@Body() required List<CreateModuleReq>? body});

  ///
  ///@param id
  Future<chopper.Response<ModuleRes>> moduleIdGet({required String? id}) {
    generatedMapping.putIfAbsent(ModuleRes, () => ModuleRes.fromJsonFactory);

    return _moduleIdGet(id: id);
  }

  ///
  ///@param id
  @Get(path: '/Module/{id}')
  Future<chopper.Response<ModuleRes>> _moduleIdGet(
      {@Path('id') required String? id});

  ///
  ///@param semester
  ///@param posterId
  ///@param moduleId
  ///@param indexId
  ///@param lookId
  Future<chopper.Response<List<PostPrincipalResp>>> postGet(
      {String? semester,
      String? posterId,
      String? moduleId,
      String? indexId,
      String? lookId}) {
    generatedMapping.putIfAbsent(
        PostPrincipalResp, () => PostPrincipalResp.fromJsonFactory);

    return _postGet(
        semester: semester,
        posterId: posterId,
        moduleId: moduleId,
        indexId: indexId,
        lookId: lookId);
  }

  ///
  ///@param semester
  ///@param posterId
  ///@param moduleId
  ///@param indexId
  ///@param lookId
  @Get(path: '/Post')
  Future<chopper.Response<List<PostPrincipalResp>>> _postGet(
      {@Query('semester') String? semester,
      @Query('posterId') String? posterId,
      @Query('moduleId') String? moduleId,
      @Query('indexId') String? indexId,
      @Query('lookId') String? lookId});

  ///
  Future<chopper.Response> postPost({required CreatePostReq? body}) {
    return _postPost(body: body);
  }

  ///
  @Post(path: '/Post')
  Future<chopper.Response> _postPost({@Body() required CreatePostReq? body});

  ///
  ///@param id
  Future<chopper.Response<PostResp>> postIdGet({required String? id}) {
    generatedMapping.putIfAbsent(PostResp, () => PostResp.fromJsonFactory);

    return _postIdGet(id: id);
  }

  ///
  ///@param id
  @Get(path: '/Post/{id}')
  Future<chopper.Response<PostResp>> _postIdGet(
      {@Path('id') required String? id});

  ///
  ///@param id
  Future<chopper.Response> postIdDelete({required String? id}) {
    return _postIdDelete(id: id);
  }

  ///
  ///@param id
  @Delete(path: '/Post/{id}')
  Future<chopper.Response> _postIdDelete({@Path('id') required String? id});

  ///
  ///@param postId
  ///@param appId
  Future<chopper.Response> postRejectPostIdAppIdPost(
      {required String? postId, required String? appId}) {
    return _postRejectPostIdAppIdPost(postId: postId, appId: appId);
  }

  ///
  ///@param postId
  ///@param appId
  @Post(path: '/Post/reject/{postId}/{appId}', optionalBody: true)
  Future<chopper.Response> _postRejectPostIdAppIdPost(
      {@Path('postId') required String? postId,
      @Path('appId') required String? appId});

  ///
  ///@param postId
  ///@param appId
  Future<chopper.Response> postAcceptPostIdAppIdPost(
      {required String? postId, required String? appId}) {
    return _postAcceptPostIdAppIdPost(postId: postId, appId: appId);
  }

  ///
  ///@param postId
  ///@param appId
  @Post(path: '/Post/accept/{postId}/{appId}', optionalBody: true)
  Future<chopper.Response> _postAcceptPostIdAppIdPost(
      {@Path('postId') required String? postId,
      @Path('appId') required String? appId});

  ///
  Future<chopper.Response<List<SemesterRes>>> semesterGet() {
    generatedMapping.putIfAbsent(
        SemesterRes, () => SemesterRes.fromJsonFactory);

    return _semesterGet();
  }

  ///
  @Get(path: '/Semester')
  Future<chopper.Response<List<SemesterRes>>> _semesterGet();

  ///
  Future<chopper.Response<SemesterRes>> semesterPost(
      {required CreateSemesterReq? body}) {
    generatedMapping.putIfAbsent(
        SemesterRes, () => SemesterRes.fromJsonFactory);

    return _semesterPost(body: body);
  }

  ///
  @Post(path: '/Semester')
  Future<chopper.Response<SemesterRes>> _semesterPost(
      {@Body() required CreateSemesterReq? body});

  ///
  Future<chopper.Response> semesterCurrentPost(
      {required CreateSemesterReq? body}) {
    return _semesterCurrentPost(body: body);
  }

  ///
  @Post(path: '/Semester/current')
  Future<chopper.Response> _semesterCurrentPost(
      {@Body() required CreateSemesterReq? body});

  ///
  Future<chopper.Response<String>> currentGet() {
    return _currentGet();
  }

  ///
  @Get(path: '/current')
  Future<chopper.Response<String>> _currentGet();

  ///
  Future<chopper.Response<List<UserPrincipalResp>>> userGet() {
    generatedMapping.putIfAbsent(
        UserPrincipalResp, () => UserPrincipalResp.fromJsonFactory);

    return _userGet();
  }

  ///
  @Get(path: '/User')
  Future<chopper.Response<List<UserPrincipalResp>>> _userGet();

  ///
  Future<chopper.Response<UserPrincipalResp>> userPost(
      {required CreateUserReq? body}) {
    generatedMapping.putIfAbsent(
        UserPrincipalResp, () => UserPrincipalResp.fromJsonFactory);

    return _userPost(body: body);
  }

  ///
  @Post(path: '/User')
  Future<chopper.Response<UserPrincipalResp>> _userPost(
      {@Body() required CreateUserReq? body});

  ///
  Future<chopper.Response<UserPrincipalResp>> userSelfGet() {
    generatedMapping.putIfAbsent(
        UserPrincipalResp, () => UserPrincipalResp.fromJsonFactory);

    return _userSelfGet();
  }

  ///
  @Get(path: '/User/self')
  Future<chopper.Response<UserPrincipalResp>> _userSelfGet();

  ///
  ///@param id
  Future<chopper.Response<UserPrincipalResp>> userIdGet({required String? id}) {
    generatedMapping.putIfAbsent(
        UserPrincipalResp, () => UserPrincipalResp.fromJsonFactory);

    return _userIdGet(id: id);
  }

  ///
  ///@param id
  @Get(path: '/User/{id}')
  Future<chopper.Response<UserPrincipalResp>> _userIdGet(
      {@Path('id') required String? id});

  ///
  ///@param id
  Future<chopper.Response<UserPrincipalResp>> userIdPut(
      {required String? id, required UpdateUserReq? body}) {
    generatedMapping.putIfAbsent(
        UserPrincipalResp, () => UserPrincipalResp.fromJsonFactory);

    return _userIdPut(id: id, body: body);
  }

  ///
  ///@param id
  @Put(path: '/User/{id}')
  Future<chopper.Response<UserPrincipalResp>> _userIdPut(
      {@Path('id') required String? id, @Body() required UpdateUserReq? body});

  ///
  ///@param id
  Future<chopper.Response> userIdDelete({required String? id}) {
    return _userIdDelete(id: id);
  }

  ///
  ///@param id
  @Delete(path: '/User/{id}')
  Future<chopper.Response> _userIdDelete({@Path('id') required String? id});
}

@JsonSerializable(explicitToJson: true)
class ApplicationPrincipalRes {
  ApplicationPrincipalRes({
    this.id,
    this.postId,
    this.status,
    this.user,
    this.offers,
  });

  factory ApplicationPrincipalRes.fromJson(Map<String, dynamic> json) =>
      _$ApplicationPrincipalResFromJson(json);

  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'postId')
  final String? postId;
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'user')
  final UserPrincipalResp? user;
  @JsonKey(name: 'offers', defaultValue: <IndexPrincipalRes>[])
  final List<IndexPrincipalRes>? offers;
  static const fromJsonFactory = _$ApplicationPrincipalResFromJson;
  static const toJsonFactory = _$ApplicationPrincipalResToJson;
  Map<String, dynamic> toJson() => _$ApplicationPrincipalResToJson(this);

  @override
  String toString() => jsonEncode(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ApplicationPrincipalRes &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.postId, postId) ||
                const DeepCollectionEquality().equals(other.postId, postId)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.offers, offers) ||
                const DeepCollectionEquality().equals(other.offers, offers)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(postId) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(user) ^
      const DeepCollectionEquality().hash(offers) ^
      runtimeType.hashCode;
}

extension $ApplicationPrincipalResExtension on ApplicationPrincipalRes {
  ApplicationPrincipalRes copyWith(
      {String? id,
      String? postId,
      String? status,
      UserPrincipalResp? user,
      List<IndexPrincipalRes>? offers}) {
    return ApplicationPrincipalRes(
        id: id ?? this.id,
        postId: postId ?? this.postId,
        status: status ?? this.status,
        user: user ?? this.user,
        offers: offers ?? this.offers);
  }
}

@JsonSerializable(explicitToJson: true)
class ApplicationRes {
  ApplicationRes({
    this.principal,
    this.post,
  });

  factory ApplicationRes.fromJson(Map<String, dynamic> json) =>
      _$ApplicationResFromJson(json);

  @JsonKey(name: 'principal')
  final ApplicationPrincipalRes? principal;
  @JsonKey(name: 'post')
  final PostPrincipalResp? post;
  static const fromJsonFactory = _$ApplicationResFromJson;
  static const toJsonFactory = _$ApplicationResToJson;
  Map<String, dynamic> toJson() => _$ApplicationResToJson(this);

  @override
  String toString() => jsonEncode(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ApplicationRes &&
            (identical(other.principal, principal) ||
                const DeepCollectionEquality()
                    .equals(other.principal, principal)) &&
            (identical(other.post, post) ||
                const DeepCollectionEquality().equals(other.post, post)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(principal) ^
      const DeepCollectionEquality().hash(post) ^
      runtimeType.hashCode;
}

extension $ApplicationResExtension on ApplicationRes {
  ApplicationRes copyWith(
      {ApplicationPrincipalRes? principal, PostPrincipalResp? post}) {
    return ApplicationRes(
        principal: principal ?? this.principal, post: post ?? this.post);
  }
}

@JsonSerializable(explicitToJson: true)
class CreateApplicationReq {
  CreateApplicationReq({
    this.offerId,
  });

  factory CreateApplicationReq.fromJson(Map<String, dynamic> json) =>
      _$CreateApplicationReqFromJson(json);

  @JsonKey(name: 'offerId', defaultValue: <String>[])
  final List<String>? offerId;
  static const fromJsonFactory = _$CreateApplicationReqFromJson;
  static const toJsonFactory = _$CreateApplicationReqToJson;
  Map<String, dynamic> toJson() => _$CreateApplicationReqToJson(this);

  @override
  String toString() => jsonEncode(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CreateApplicationReq &&
            (identical(other.offerId, offerId) ||
                const DeepCollectionEquality().equals(other.offerId, offerId)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(offerId) ^ runtimeType.hashCode;
}

extension $CreateApplicationReqExtension on CreateApplicationReq {
  CreateApplicationReq copyWith({List<String>? offerId}) {
    return CreateApplicationReq(offerId: offerId ?? this.offerId);
  }
}

@JsonSerializable(explicitToJson: true)
class CreateIndexReq {
  CreateIndexReq({
    this.moduleId,
    this.code,
    this.props,
  });

  factory CreateIndexReq.fromJson(Map<String, dynamic> json) =>
      _$CreateIndexReqFromJson(json);

  @JsonKey(name: 'moduleId')
  final String? moduleId;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'props', defaultValue: <CreateIndexSingleReq>[])
  final List<CreateIndexSingleReq>? props;
  static const fromJsonFactory = _$CreateIndexReqFromJson;
  static const toJsonFactory = _$CreateIndexReqToJson;
  Map<String, dynamic> toJson() => _$CreateIndexReqToJson(this);

  @override
  String toString() => jsonEncode(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CreateIndexReq &&
            (identical(other.moduleId, moduleId) ||
                const DeepCollectionEquality()
                    .equals(other.moduleId, moduleId)) &&
            (identical(other.code, code) ||
                const DeepCollectionEquality().equals(other.code, code)) &&
            (identical(other.props, props) ||
                const DeepCollectionEquality().equals(other.props, props)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(moduleId) ^
      const DeepCollectionEquality().hash(code) ^
      const DeepCollectionEquality().hash(props) ^
      runtimeType.hashCode;
}

extension $CreateIndexReqExtension on CreateIndexReq {
  CreateIndexReq copyWith(
      {String? moduleId, String? code, List<CreateIndexSingleReq>? props}) {
    return CreateIndexReq(
        moduleId: moduleId ?? this.moduleId,
        code: code ?? this.code,
        props: props ?? this.props);
  }
}

@JsonSerializable(explicitToJson: true)
class CreateIndexSingleReq {
  CreateIndexSingleReq({
    this.group,
    this.type,
    this.day,
    this.start,
    this.stop,
    this.venue,
  });

  factory CreateIndexSingleReq.fromJson(Map<String, dynamic> json) =>
      _$CreateIndexSingleReqFromJson(json);

  @JsonKey(name: 'group')
  final String? group;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'day')
  final String? day;
  @JsonKey(name: 'start')
  final String? start;
  @JsonKey(name: 'stop')
  final String? stop;
  @JsonKey(name: 'venue')
  final String? venue;
  static const fromJsonFactory = _$CreateIndexSingleReqFromJson;
  static const toJsonFactory = _$CreateIndexSingleReqToJson;
  Map<String, dynamic> toJson() => _$CreateIndexSingleReqToJson(this);

  @override
  String toString() => jsonEncode(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CreateIndexSingleReq &&
            (identical(other.group, group) ||
                const DeepCollectionEquality().equals(other.group, group)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.day, day) ||
                const DeepCollectionEquality().equals(other.day, day)) &&
            (identical(other.start, start) ||
                const DeepCollectionEquality().equals(other.start, start)) &&
            (identical(other.stop, stop) ||
                const DeepCollectionEquality().equals(other.stop, stop)) &&
            (identical(other.venue, venue) ||
                const DeepCollectionEquality().equals(other.venue, venue)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(group) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(day) ^
      const DeepCollectionEquality().hash(start) ^
      const DeepCollectionEquality().hash(stop) ^
      const DeepCollectionEquality().hash(venue) ^
      runtimeType.hashCode;
}

extension $CreateIndexSingleReqExtension on CreateIndexSingleReq {
  CreateIndexSingleReq copyWith(
      {String? group,
      String? type,
      String? day,
      String? start,
      String? stop,
      String? venue}) {
    return CreateIndexSingleReq(
        group: group ?? this.group,
        type: type ?? this.type,
        day: day ?? this.day,
        start: start ?? this.start,
        stop: stop ?? this.stop,
        venue: venue ?? this.venue);
  }
}

@JsonSerializable(explicitToJson: true)
class CreateModuleReq {
  CreateModuleReq({
    this.semester,
    this.courseCode,
    this.name,
    this.description,
    this.academicUnit,
  });

  factory CreateModuleReq.fromJson(Map<String, dynamic> json) =>
      _$CreateModuleReqFromJson(json);

  @JsonKey(name: 'semester')
  final String? semester;
  @JsonKey(name: 'courseCode')
  final String? courseCode;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'academicUnit')
  final int? academicUnit;
  static const fromJsonFactory = _$CreateModuleReqFromJson;
  static const toJsonFactory = _$CreateModuleReqToJson;
  Map<String, dynamic> toJson() => _$CreateModuleReqToJson(this);

  @override
  String toString() => jsonEncode(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CreateModuleReq &&
            (identical(other.semester, semester) ||
                const DeepCollectionEquality()
                    .equals(other.semester, semester)) &&
            (identical(other.courseCode, courseCode) ||
                const DeepCollectionEquality()
                    .equals(other.courseCode, courseCode)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.academicUnit, academicUnit) ||
                const DeepCollectionEquality()
                    .equals(other.academicUnit, academicUnit)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(semester) ^
      const DeepCollectionEquality().hash(courseCode) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(academicUnit) ^
      runtimeType.hashCode;
}

extension $CreateModuleReqExtension on CreateModuleReq {
  CreateModuleReq copyWith(
      {String? semester,
      String? courseCode,
      String? name,
      String? description,
      int? academicUnit}) {
    return CreateModuleReq(
        semester: semester ?? this.semester,
        courseCode: courseCode ?? this.courseCode,
        name: name ?? this.name,
        description: description ?? this.description,
        academicUnit: academicUnit ?? this.academicUnit);
  }
}

@JsonSerializable(explicitToJson: true)
class CreatePostReq {
  CreatePostReq({
    this.modulesId,
    this.indexId,
    this.lookingForId,
  });

  factory CreatePostReq.fromJson(Map<String, dynamic> json) =>
      _$CreatePostReqFromJson(json);

  @JsonKey(name: 'modulesId')
  final String? modulesId;
  @JsonKey(name: 'indexId')
  final String? indexId;
  @JsonKey(name: 'lookingForId', defaultValue: <String>[])
  final List<String>? lookingForId;
  static const fromJsonFactory = _$CreatePostReqFromJson;
  static const toJsonFactory = _$CreatePostReqToJson;
  Map<String, dynamic> toJson() => _$CreatePostReqToJson(this);

  @override
  String toString() => jsonEncode(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CreatePostReq &&
            (identical(other.modulesId, modulesId) ||
                const DeepCollectionEquality()
                    .equals(other.modulesId, modulesId)) &&
            (identical(other.indexId, indexId) ||
                const DeepCollectionEquality()
                    .equals(other.indexId, indexId)) &&
            (identical(other.lookingForId, lookingForId) ||
                const DeepCollectionEquality()
                    .equals(other.lookingForId, lookingForId)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(modulesId) ^
      const DeepCollectionEquality().hash(indexId) ^
      const DeepCollectionEquality().hash(lookingForId) ^
      runtimeType.hashCode;
}

extension $CreatePostReqExtension on CreatePostReq {
  CreatePostReq copyWith(
      {String? modulesId, String? indexId, List<String>? lookingForId}) {
    return CreatePostReq(
        modulesId: modulesId ?? this.modulesId,
        indexId: indexId ?? this.indexId,
        lookingForId: lookingForId ?? this.lookingForId);
  }
}

@JsonSerializable(explicitToJson: true)
class CreateSemesterReq {
  CreateSemesterReq({
    this.semester,
  });

  factory CreateSemesterReq.fromJson(Map<String, dynamic> json) =>
      _$CreateSemesterReqFromJson(json);

  @JsonKey(name: 'semester')
  final String? semester;
  static const fromJsonFactory = _$CreateSemesterReqFromJson;
  static const toJsonFactory = _$CreateSemesterReqToJson;
  Map<String, dynamic> toJson() => _$CreateSemesterReqToJson(this);

  @override
  String toString() => jsonEncode(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CreateSemesterReq &&
            (identical(other.semester, semester) ||
                const DeepCollectionEquality()
                    .equals(other.semester, semester)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(semester) ^ runtimeType.hashCode;
}

extension $CreateSemesterReqExtension on CreateSemesterReq {
  CreateSemesterReq copyWith({String? semester}) {
    return CreateSemesterReq(semester: semester ?? this.semester);
  }
}

@JsonSerializable(explicitToJson: true)
class CreateUserReq {
  CreateUserReq({
    this.name,
    this.email,
  });

  factory CreateUserReq.fromJson(Map<String, dynamic> json) =>
      _$CreateUserReqFromJson(json);

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'email')
  final String? email;
  static const fromJsonFactory = _$CreateUserReqFromJson;
  static const toJsonFactory = _$CreateUserReqToJson;
  Map<String, dynamic> toJson() => _$CreateUserReqToJson(this);

  @override
  String toString() => jsonEncode(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CreateUserReq &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(email) ^
      runtimeType.hashCode;
}

extension $CreateUserReqExtension on CreateUserReq {
  CreateUserReq copyWith({String? name, String? email}) {
    return CreateUserReq(name: name ?? this.name, email: email ?? this.email);
  }
}

@JsonSerializable(explicitToJson: true)
class IndexPrincipalRes {
  IndexPrincipalRes({
    this.id,
    this.code,
    this.props,
  });

  factory IndexPrincipalRes.fromJson(Map<String, dynamic> json) =>
      _$IndexPrincipalResFromJson(json);

  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'props', defaultValue: <IndexPropsRes>[])
  final List<IndexPropsRes>? props;
  static const fromJsonFactory = _$IndexPrincipalResFromJson;
  static const toJsonFactory = _$IndexPrincipalResToJson;
  Map<String, dynamic> toJson() => _$IndexPrincipalResToJson(this);

  @override
  String toString() => jsonEncode(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is IndexPrincipalRes &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.code, code) ||
                const DeepCollectionEquality().equals(other.code, code)) &&
            (identical(other.props, props) ||
                const DeepCollectionEquality().equals(other.props, props)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(code) ^
      const DeepCollectionEquality().hash(props) ^
      runtimeType.hashCode;
}

extension $IndexPrincipalResExtension on IndexPrincipalRes {
  IndexPrincipalRes copyWith(
      {String? id, String? code, List<IndexPropsRes>? props}) {
    return IndexPrincipalRes(
        id: id ?? this.id, code: code ?? this.code, props: props ?? this.props);
  }
}

@JsonSerializable(explicitToJson: true)
class IndexPropsRes {
  IndexPropsRes({
    this.group,
    this.type,
    this.day,
    this.start,
    this.stop,
    this.venue,
  });

  factory IndexPropsRes.fromJson(Map<String, dynamic> json) =>
      _$IndexPropsResFromJson(json);

  @JsonKey(name: 'group')
  final String? group;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'day')
  final String? day;
  @JsonKey(name: 'start')
  final String? start;
  @JsonKey(name: 'stop')
  final String? stop;
  @JsonKey(name: 'venue')
  final String? venue;
  static const fromJsonFactory = _$IndexPropsResFromJson;
  static const toJsonFactory = _$IndexPropsResToJson;
  Map<String, dynamic> toJson() => _$IndexPropsResToJson(this);

  @override
  String toString() => jsonEncode(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is IndexPropsRes &&
            (identical(other.group, group) ||
                const DeepCollectionEquality().equals(other.group, group)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.day, day) ||
                const DeepCollectionEquality().equals(other.day, day)) &&
            (identical(other.start, start) ||
                const DeepCollectionEquality().equals(other.start, start)) &&
            (identical(other.stop, stop) ||
                const DeepCollectionEquality().equals(other.stop, stop)) &&
            (identical(other.venue, venue) ||
                const DeepCollectionEquality().equals(other.venue, venue)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(group) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(day) ^
      const DeepCollectionEquality().hash(start) ^
      const DeepCollectionEquality().hash(stop) ^
      const DeepCollectionEquality().hash(venue) ^
      runtimeType.hashCode;
}

extension $IndexPropsResExtension on IndexPropsRes {
  IndexPropsRes copyWith(
      {String? group,
      String? type,
      String? day,
      String? start,
      String? stop,
      String? venue}) {
    return IndexPropsRes(
        group: group ?? this.group,
        type: type ?? this.type,
        day: day ?? this.day,
        start: start ?? this.start,
        stop: stop ?? this.stop,
        venue: venue ?? this.venue);
  }
}

@JsonSerializable(explicitToJson: true)
class IndexRes {
  IndexRes({
    this.principal,
    this.module,
  });

  factory IndexRes.fromJson(Map<String, dynamic> json) =>
      _$IndexResFromJson(json);

  @JsonKey(name: 'principal')
  final IndexPrincipalRes? principal;
  @JsonKey(name: 'module')
  final ModulePrincipalRes? module;
  static const fromJsonFactory = _$IndexResFromJson;
  static const toJsonFactory = _$IndexResToJson;
  Map<String, dynamic> toJson() => _$IndexResToJson(this);

  @override
  String toString() => jsonEncode(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is IndexRes &&
            (identical(other.principal, principal) ||
                const DeepCollectionEquality()
                    .equals(other.principal, principal)) &&
            (identical(other.module, module) ||
                const DeepCollectionEquality().equals(other.module, module)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(principal) ^
      const DeepCollectionEquality().hash(module) ^
      runtimeType.hashCode;
}

extension $IndexResExtension on IndexRes {
  IndexRes copyWith(
      {IndexPrincipalRes? principal, ModulePrincipalRes? module}) {
    return IndexRes(
        principal: principal ?? this.principal, module: module ?? this.module);
  }
}

@JsonSerializable(explicitToJson: true)
class ModulePrincipalRes {
  ModulePrincipalRes({
    this.id,
    this.semester,
    this.courseCode,
    this.name,
    this.description,
    this.academicUnit,
  });

  factory ModulePrincipalRes.fromJson(Map<String, dynamic> json) =>
      _$ModulePrincipalResFromJson(json);

  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'semester')
  final String? semester;
  @JsonKey(name: 'courseCode')
  final String? courseCode;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'academicUnit')
  final int? academicUnit;
  static const fromJsonFactory = _$ModulePrincipalResFromJson;
  static const toJsonFactory = _$ModulePrincipalResToJson;
  Map<String, dynamic> toJson() => _$ModulePrincipalResToJson(this);

  @override
  String toString() => jsonEncode(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ModulePrincipalRes &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.semester, semester) ||
                const DeepCollectionEquality()
                    .equals(other.semester, semester)) &&
            (identical(other.courseCode, courseCode) ||
                const DeepCollectionEquality()
                    .equals(other.courseCode, courseCode)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.academicUnit, academicUnit) ||
                const DeepCollectionEquality()
                    .equals(other.academicUnit, academicUnit)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(semester) ^
      const DeepCollectionEquality().hash(courseCode) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(academicUnit) ^
      runtimeType.hashCode;
}

extension $ModulePrincipalResExtension on ModulePrincipalRes {
  ModulePrincipalRes copyWith(
      {String? id,
      String? semester,
      String? courseCode,
      String? name,
      String? description,
      int? academicUnit}) {
    return ModulePrincipalRes(
        id: id ?? this.id,
        semester: semester ?? this.semester,
        courseCode: courseCode ?? this.courseCode,
        name: name ?? this.name,
        description: description ?? this.description,
        academicUnit: academicUnit ?? this.academicUnit);
  }
}

@JsonSerializable(explicitToJson: true)
class ModuleRes {
  ModuleRes({
    this.principal,
    this.indexes,
  });

  factory ModuleRes.fromJson(Map<String, dynamic> json) =>
      _$ModuleResFromJson(json);

  @JsonKey(name: 'principal')
  final ModulePrincipalRes? principal;
  @JsonKey(name: 'indexes', defaultValue: <IndexPrincipalRes>[])
  final List<IndexPrincipalRes>? indexes;
  static const fromJsonFactory = _$ModuleResFromJson;
  static const toJsonFactory = _$ModuleResToJson;
  Map<String, dynamic> toJson() => _$ModuleResToJson(this);

  @override
  String toString() => jsonEncode(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ModuleRes &&
            (identical(other.principal, principal) ||
                const DeepCollectionEquality()
                    .equals(other.principal, principal)) &&
            (identical(other.indexes, indexes) ||
                const DeepCollectionEquality().equals(other.indexes, indexes)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(principal) ^
      const DeepCollectionEquality().hash(indexes) ^
      runtimeType.hashCode;
}

extension $ModuleResExtension on ModuleRes {
  ModuleRes copyWith(
      {ModulePrincipalRes? principal, List<IndexPrincipalRes>? indexes}) {
    return ModuleRes(
        principal: principal ?? this.principal,
        indexes: indexes ?? this.indexes);
  }
}

@JsonSerializable(explicitToJson: true)
class PostPrincipalResp {
  PostPrincipalResp({
    this.id,
    this.ownerId,
    this.index,
    this.module,
    this.completed,
    this.lookingFor,
  });

  factory PostPrincipalResp.fromJson(Map<String, dynamic> json) =>
      _$PostPrincipalRespFromJson(json);

  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'ownerId')
  final String? ownerId;
  @JsonKey(name: 'index')
  final IndexPrincipalRes? index;
  @JsonKey(name: 'module')
  final ModulePrincipalRes? module;
  @JsonKey(name: 'completed')
  final bool? completed;
  @JsonKey(name: 'lookingFor', defaultValue: <IndexPrincipalRes>[])
  final List<IndexPrincipalRes>? lookingFor;
  static const fromJsonFactory = _$PostPrincipalRespFromJson;
  static const toJsonFactory = _$PostPrincipalRespToJson;
  Map<String, dynamic> toJson() => _$PostPrincipalRespToJson(this);

  @override
  String toString() => jsonEncode(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PostPrincipalResp &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.ownerId, ownerId) ||
                const DeepCollectionEquality()
                    .equals(other.ownerId, ownerId)) &&
            (identical(other.index, index) ||
                const DeepCollectionEquality().equals(other.index, index)) &&
            (identical(other.module, module) ||
                const DeepCollectionEquality().equals(other.module, module)) &&
            (identical(other.completed, completed) ||
                const DeepCollectionEquality()
                    .equals(other.completed, completed)) &&
            (identical(other.lookingFor, lookingFor) ||
                const DeepCollectionEquality()
                    .equals(other.lookingFor, lookingFor)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(ownerId) ^
      const DeepCollectionEquality().hash(index) ^
      const DeepCollectionEquality().hash(module) ^
      const DeepCollectionEquality().hash(completed) ^
      const DeepCollectionEquality().hash(lookingFor) ^
      runtimeType.hashCode;
}

extension $PostPrincipalRespExtension on PostPrincipalResp {
  PostPrincipalResp copyWith(
      {String? id,
      String? ownerId,
      IndexPrincipalRes? index,
      ModulePrincipalRes? module,
      bool? completed,
      List<IndexPrincipalRes>? lookingFor}) {
    return PostPrincipalResp(
        id: id ?? this.id,
        ownerId: ownerId ?? this.ownerId,
        index: index ?? this.index,
        module: module ?? this.module,
        completed: completed ?? this.completed,
        lookingFor: lookingFor ?? this.lookingFor);
  }
}

@JsonSerializable(explicitToJson: true)
class PostResp {
  PostResp({
    this.user,
    this.post,
    this.applications,
  });

  factory PostResp.fromJson(Map<String, dynamic> json) =>
      _$PostRespFromJson(json);

  @JsonKey(name: 'user')
  final UserPrincipalResp? user;
  @JsonKey(name: 'post')
  final PostPrincipalResp? post;
  @JsonKey(name: 'applications', defaultValue: <ApplicationPrincipalRes>[])
  final List<ApplicationPrincipalRes>? applications;
  static const fromJsonFactory = _$PostRespFromJson;
  static const toJsonFactory = _$PostRespToJson;
  Map<String, dynamic> toJson() => _$PostRespToJson(this);

  @override
  String toString() => jsonEncode(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PostResp &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.post, post) ||
                const DeepCollectionEquality().equals(other.post, post)) &&
            (identical(other.applications, applications) ||
                const DeepCollectionEquality()
                    .equals(other.applications, applications)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(user) ^
      const DeepCollectionEquality().hash(post) ^
      const DeepCollectionEquality().hash(applications) ^
      runtimeType.hashCode;
}

extension $PostRespExtension on PostResp {
  PostResp copyWith(
      {UserPrincipalResp? user,
      PostPrincipalResp? post,
      List<ApplicationPrincipalRes>? applications}) {
    return PostResp(
        user: user ?? this.user,
        post: post ?? this.post,
        applications: applications ?? this.applications);
  }
}

@JsonSerializable(explicitToJson: true)
class SemesterRes {
  SemesterRes({
    this.semester,
    this.current,
  });

  factory SemesterRes.fromJson(Map<String, dynamic> json) =>
      _$SemesterResFromJson(json);

  @JsonKey(name: 'semester')
  final String? semester;
  @JsonKey(name: 'current')
  final bool? current;
  static const fromJsonFactory = _$SemesterResFromJson;
  static const toJsonFactory = _$SemesterResToJson;
  Map<String, dynamic> toJson() => _$SemesterResToJson(this);

  @override
  String toString() => jsonEncode(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SemesterRes &&
            (identical(other.semester, semester) ||
                const DeepCollectionEquality()
                    .equals(other.semester, semester)) &&
            (identical(other.current, current) ||
                const DeepCollectionEquality().equals(other.current, current)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(semester) ^
      const DeepCollectionEquality().hash(current) ^
      runtimeType.hashCode;
}

extension $SemesterResExtension on SemesterRes {
  SemesterRes copyWith({String? semester, bool? current}) {
    return SemesterRes(
        semester: semester ?? this.semester, current: current ?? this.current);
  }
}

@JsonSerializable(explicitToJson: true)
class UpdateUserReq {
  UpdateUserReq({
    this.name,
    this.email,
  });

  factory UpdateUserReq.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserReqFromJson(json);

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'email')
  final String? email;
  static const fromJsonFactory = _$UpdateUserReqFromJson;
  static const toJsonFactory = _$UpdateUserReqToJson;
  Map<String, dynamic> toJson() => _$UpdateUserReqToJson(this);

  @override
  String toString() => jsonEncode(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UpdateUserReq &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(email) ^
      runtimeType.hashCode;
}

extension $UpdateUserReqExtension on UpdateUserReq {
  UpdateUserReq copyWith({String? name, String? email}) {
    return UpdateUserReq(name: name ?? this.name, email: email ?? this.email);
  }
}

@JsonSerializable(explicitToJson: true)
class UserPrincipalResp {
  UserPrincipalResp({
    this.id,
    this.name,
    this.email,
    this.sub,
  });

  factory UserPrincipalResp.fromJson(Map<String, dynamic> json) =>
      _$UserPrincipalRespFromJson(json);

  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'sub')
  final String? sub;
  static const fromJsonFactory = _$UserPrincipalRespFromJson;
  static const toJsonFactory = _$UserPrincipalRespToJson;
  Map<String, dynamic> toJson() => _$UserPrincipalRespToJson(this);

  @override
  String toString() => jsonEncode(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserPrincipalResp &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.sub, sub) ||
                const DeepCollectionEquality().equals(other.sub, sub)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(sub) ^
      runtimeType.hashCode;
}

extension $UserPrincipalRespExtension on UserPrincipalResp {
  UserPrincipalResp copyWith(
      {String? id, String? name, String? email, String? sub}) {
    return UserPrincipalResp(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        sub: sub ?? this.sub);
  }
}

typedef $JsonFactory<T> = T Function(Map<String, dynamic> json);

class $CustomJsonDecoder {
  $CustomJsonDecoder(this.factories);

  final Map<Type, $JsonFactory> factories;

  dynamic decode<T>(dynamic entity) {
    if (entity is Iterable) {
      return _decodeList<T>(entity);
    }

    if (entity is T) {
      return entity;
    }

    if (entity is Map<String, dynamic>) {
      return _decodeMap<T>(entity);
    }

    return entity;
  }

  T _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! $JsonFactory<T>) {
      return throw "Could not find factory for type $T. Is '$T: $T.fromJsonFactory' included in the CustomJsonDecoder instance creation in bootstrapper.dart?";
    }

    return jsonFactory(values);
  }

  List<T> _decodeList<T>(Iterable values) =>
      values.where((v) => v != null).map<T>((v) => decode<T>(v) as T).toList();
}

class $JsonSerializableConverter extends chopper.JsonConverter {
  @override
  chopper.Response<ResultType> convertResponse<ResultType, Item>(
      chopper.Response response) {
    if (response.bodyString.isEmpty) {
      // In rare cases, when let's say 204 (no content) is returned -
      // we cannot decode the missing json with the result type specified
      return chopper.Response(response.base, null, error: response.error);
    }

    final jsonRes = super.convertResponse(response);
    return jsonRes.copyWith<ResultType>(
        body: $jsonDecoder.decode<Item>(jsonRes.body) as ResultType);
  }
}

final $jsonDecoder = $CustomJsonDecoder(generatedMapping);

// ignore: unused_element
String? _dateToJson(DateTime? date) {
  if (date == null) {
    return null;
  }

  final year = date.year.toString();
  final month = date.month < 10 ? '0${date.month}' : date.month.toString();
  final day = date.day < 10 ? '0${date.day}' : date.day.toString();

  return '$year-$month-$day';
}
