class UserModel {
  final String email;
  final String displayName;
  final String photoURL;
  final String uid;
  final String username;

  UserModel({
    required this.email,
    required this.displayName,
    required this.photoURL,
    required this.uid,
    required this.username,
  });

  UserModel copyWith({email, displayName, photoURL, uid, username}) {
    return UserModel(
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoURL: photoURL ?? this.photoURL,
      uid: uid ?? this.uid,
      username: username ?? this.username,
    );
  }
}
