import 'package:equatable/equatable.dart';

class FriendListItemModel extends Equatable {
  final DateTime createdAt;
  final String lastMessage;
  final String displayName;
  final String photoURL;
  final String uid;

  const FriendListItemModel(
    this.createdAt,
    this.lastMessage,
    this.displayName,
    this.photoURL,
    this.uid,
  );

  Map<String, dynamic> toJson() {
    return {
      "createdAt": (createdAt.millisecondsSinceEpoch / 1000).round(),
      "lastMessage": lastMessage,
      "uid": uid,
      "displayName": displayName,
      "photoURL": photoURL,
    };
  }

  static FriendListItemModel fromJson(Map<String, dynamic> json) {
    DateTime time;
    if (json["createdAt"].runtimeType == String) {
      time = DateTime.fromMillisecondsSinceEpoch(
          double.parse(json["createdAt"]).round() * 1000);
    } else if (json["createdAt"].runtimeType == int) {
      time = DateTime.fromMillisecondsSinceEpoch(json["createdAt"] * 1000);
    } else {
      time = DateTime.fromMillisecondsSinceEpoch(
          (json["createdAt"] as double).round() * 1000);
    }
    return FriendListItemModel(
      time,
      json["lastMessage"],
      json["displayName"],
      json["photoURL"],
      json["uid"],
    );
  }

  @override
  List<Object?> get props => [
        createdAt,
        lastMessage,
        displayName,
        photoURL,
        uid,
      ];
}
