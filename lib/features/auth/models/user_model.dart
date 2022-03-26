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

  Map<String, dynamic> toJson() {
    return {
      "displayName": displayName,
      "email": email,
      "photoURL": photoURL,
      "uid": uid,
      "username": username,
    };
  }

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json["email"] as String,
      displayName: json["displayName"] as String,
      photoURL: json["photoURL"] as String,
      uid: json["uid"] as String,
      username: json["username"] as String,
    );
  }
}
