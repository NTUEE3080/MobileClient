import 'package:coursecupid/auth/lib/user.dart';

import '../api_lib/swagger.swagger.dart';

class PostViewModel {
  final String id;
  final IndexPrincipalRes index;
  final ModulePrincipalRes module;
  final bool completed;
  final List<IndexPrincipalRes> lookingFor;
  final bool applied;
  final bool self;

  PostViewModel(this.id, this.index, this.module, this.completed,
      this.lookingFor, this.applied, this.self);

  static PostViewModel from(PostPrincipalResp post,
      List<ApplicationPrincipalRes> applied, AuthMetaUser user) {
    return PostViewModel(
      post.id!,
      post.index!,
      post.module!,
      post.completed!,
      post.lookingFor!,
      applied.any((e) => e.postId == post.id),
      user.data?.guid == post.ownerId,
    );
  }
}
