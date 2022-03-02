class AuthMetaUser {
  bool loggedIn;
  bool emailFromNTU;
  bool emailVerified;
  bool onboarded;
  AuthUserData? data;

  AuthMetaUser(this.loggedIn,
      this.emailFromNTU, this.emailVerified, this.onboarded, this.data);
}



class AuthUserData {
  final String guid;
  final String name;
  final String email;
  final String? avatar;

  const AuthUserData(this.guid, this.name, this.email, this.avatar);
}
