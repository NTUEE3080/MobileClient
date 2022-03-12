// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'swagger.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplicationPrincipalRes _$ApplicationPrincipalResFromJson(
        Map<String, dynamic> json) =>
    ApplicationPrincipalRes(
      id: json['id'] as String?,
      postId: json['postId'] as String?,
      status: json['status'] as String?,
      user: json['user'] == null
          ? null
          : UserPrincipalResp.fromJson(json['user'] as Map<String, dynamic>),
      offers: (json['offers'] as List<dynamic>?)
              ?.map(
                  (e) => IndexPrincipalRes.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$ApplicationPrincipalResToJson(
        ApplicationPrincipalRes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'postId': instance.postId,
      'status': instance.status,
      'user': instance.user?.toJson(),
      'offers': instance.offers?.map((e) => e.toJson()).toList(),
    };

ApplicationRes _$ApplicationResFromJson(Map<String, dynamic> json) =>
    ApplicationRes(
      principal: json['principal'] == null
          ? null
          : ApplicationPrincipalRes.fromJson(
              json['principal'] as Map<String, dynamic>),
      post: json['post'] == null
          ? null
          : PostPrincipalResp.fromJson(json['post'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ApplicationResToJson(ApplicationRes instance) =>
    <String, dynamic>{
      'principal': instance.principal?.toJson(),
      'post': instance.post?.toJson(),
    };

CreateApplicationReq _$CreateApplicationReqFromJson(
        Map<String, dynamic> json) =>
    CreateApplicationReq(
      offerId: (json['offerId'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$CreateApplicationReqToJson(
        CreateApplicationReq instance) =>
    <String, dynamic>{
      'offerId': instance.offerId,
    };

CreateIndexReq _$CreateIndexReqFromJson(Map<String, dynamic> json) =>
    CreateIndexReq(
      moduleId: json['moduleId'] as String?,
      code: json['code'] as String?,
      props: (json['props'] as List<dynamic>?)
              ?.map((e) =>
                  CreateIndexSingleReq.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$CreateIndexReqToJson(CreateIndexReq instance) =>
    <String, dynamic>{
      'moduleId': instance.moduleId,
      'code': instance.code,
      'props': instance.props?.map((e) => e.toJson()).toList(),
    };

CreateIndexSingleReq _$CreateIndexSingleReqFromJson(
        Map<String, dynamic> json) =>
    CreateIndexSingleReq(
      group: json['group'] as String?,
      type: json['type'] as String?,
      day: json['day'] as String?,
      start: json['start'] as String?,
      stop: json['stop'] as String?,
      venue: json['venue'] as String?,
    );

Map<String, dynamic> _$CreateIndexSingleReqToJson(
        CreateIndexSingleReq instance) =>
    <String, dynamic>{
      'group': instance.group,
      'type': instance.type,
      'day': instance.day,
      'start': instance.start,
      'stop': instance.stop,
      'venue': instance.venue,
    };

CreateModuleReq _$CreateModuleReqFromJson(Map<String, dynamic> json) =>
    CreateModuleReq(
      semester: json['semester'] as String?,
      courseCode: json['courseCode'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      academicUnit: json['academicUnit'] as int?,
    );

Map<String, dynamic> _$CreateModuleReqToJson(CreateModuleReq instance) =>
    <String, dynamic>{
      'semester': instance.semester,
      'courseCode': instance.courseCode,
      'name': instance.name,
      'description': instance.description,
      'academicUnit': instance.academicUnit,
    };

CreatePostReq _$CreatePostReqFromJson(Map<String, dynamic> json) =>
    CreatePostReq(
      modulesId: json['modulesId'] as String?,
      indexId: json['indexId'] as String?,
      lookingForId: (json['lookingForId'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$CreatePostReqToJson(CreatePostReq instance) =>
    <String, dynamic>{
      'modulesId': instance.modulesId,
      'indexId': instance.indexId,
      'lookingForId': instance.lookingForId,
    };

CreateSemesterReq _$CreateSemesterReqFromJson(Map<String, dynamic> json) =>
    CreateSemesterReq(
      semester: json['semester'] as String?,
    );

Map<String, dynamic> _$CreateSemesterReqToJson(CreateSemesterReq instance) =>
    <String, dynamic>{
      'semester': instance.semester,
    };

CreateUserReq _$CreateUserReqFromJson(Map<String, dynamic> json) =>
    CreateUserReq(
      name: json['name'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$CreateUserReqToJson(CreateUserReq instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
    };

IndexPrincipalRes _$IndexPrincipalResFromJson(Map<String, dynamic> json) =>
    IndexPrincipalRes(
      id: json['id'] as String?,
      code: json['code'] as String?,
      props: (json['props'] as List<dynamic>?)
              ?.map((e) => IndexPropsRes.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$IndexPrincipalResToJson(IndexPrincipalRes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'props': instance.props?.map((e) => e.toJson()).toList(),
    };

IndexPropsRes _$IndexPropsResFromJson(Map<String, dynamic> json) =>
    IndexPropsRes(
      group: json['group'] as String?,
      type: json['type'] as String?,
      day: json['day'] as String?,
      start: json['start'] as String?,
      stop: json['stop'] as String?,
      venue: json['venue'] as String?,
    );

Map<String, dynamic> _$IndexPropsResToJson(IndexPropsRes instance) =>
    <String, dynamic>{
      'group': instance.group,
      'type': instance.type,
      'day': instance.day,
      'start': instance.start,
      'stop': instance.stop,
      'venue': instance.venue,
    };

IndexRes _$IndexResFromJson(Map<String, dynamic> json) => IndexRes(
      principal: json['principal'] == null
          ? null
          : IndexPrincipalRes.fromJson(
              json['principal'] as Map<String, dynamic>),
      module: json['module'] == null
          ? null
          : ModulePrincipalRes.fromJson(json['module'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IndexResToJson(IndexRes instance) => <String, dynamic>{
      'principal': instance.principal?.toJson(),
      'module': instance.module?.toJson(),
    };

ModulePrincipalRes _$ModulePrincipalResFromJson(Map<String, dynamic> json) =>
    ModulePrincipalRes(
      id: json['id'] as String?,
      semester: json['semester'] as String?,
      courseCode: json['courseCode'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      academicUnit: json['academicUnit'] as int?,
    );

Map<String, dynamic> _$ModulePrincipalResToJson(ModulePrincipalRes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'semester': instance.semester,
      'courseCode': instance.courseCode,
      'name': instance.name,
      'description': instance.description,
      'academicUnit': instance.academicUnit,
    };

ModuleRes _$ModuleResFromJson(Map<String, dynamic> json) => ModuleRes(
      principal: json['principal'] == null
          ? null
          : ModulePrincipalRes.fromJson(
              json['principal'] as Map<String, dynamic>),
      indexes: (json['indexes'] as List<dynamic>?)
              ?.map(
                  (e) => IndexPrincipalRes.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$ModuleResToJson(ModuleRes instance) => <String, dynamic>{
      'principal': instance.principal?.toJson(),
      'indexes': instance.indexes?.map((e) => e.toJson()).toList(),
    };

PostPrincipalResp _$PostPrincipalRespFromJson(Map<String, dynamic> json) =>
    PostPrincipalResp(
      id: json['id'] as String?,
      ownerId: json['ownerId'] as String?,
      index: json['index'] == null
          ? null
          : IndexPrincipalRes.fromJson(json['index'] as Map<String, dynamic>),
      module: json['module'] == null
          ? null
          : ModulePrincipalRes.fromJson(json['module'] as Map<String, dynamic>),
      completed: json['completed'] as bool?,
      lookingFor: (json['lookingFor'] as List<dynamic>?)
              ?.map(
                  (e) => IndexPrincipalRes.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$PostPrincipalRespToJson(PostPrincipalResp instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ownerId': instance.ownerId,
      'index': instance.index?.toJson(),
      'module': instance.module?.toJson(),
      'completed': instance.completed,
      'lookingFor': instance.lookingFor?.map((e) => e.toJson()).toList(),
    };

PostResp _$PostRespFromJson(Map<String, dynamic> json) => PostResp(
      user: json['user'] == null
          ? null
          : UserPrincipalResp.fromJson(json['user'] as Map<String, dynamic>),
      post: json['post'] == null
          ? null
          : PostPrincipalResp.fromJson(json['post'] as Map<String, dynamic>),
      applications: (json['applications'] as List<dynamic>?)
              ?.map((e) =>
                  ApplicationPrincipalRes.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$PostRespToJson(PostResp instance) => <String, dynamic>{
      'user': instance.user?.toJson(),
      'post': instance.post?.toJson(),
      'applications': instance.applications?.map((e) => e.toJson()).toList(),
    };

SemesterRes _$SemesterResFromJson(Map<String, dynamic> json) => SemesterRes(
      semester: json['semester'] as String?,
      current: json['current'] as bool?,
    );

Map<String, dynamic> _$SemesterResToJson(SemesterRes instance) =>
    <String, dynamic>{
      'semester': instance.semester,
      'current': instance.current,
    };

UpdateUserReq _$UpdateUserReqFromJson(Map<String, dynamic> json) =>
    UpdateUserReq(
      name: json['name'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$UpdateUserReqToJson(UpdateUserReq instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
    };

UserPrincipalResp _$UserPrincipalRespFromJson(Map<String, dynamic> json) =>
    UserPrincipalResp(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      sub: json['sub'] as String?,
    );

Map<String, dynamic> _$UserPrincipalRespToJson(UserPrincipalResp instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'sub': instance.sub,
    };
