import "models.dart";

class MessageModel {
  final DateTime createdAt;
  final String? text;
  final MessageDirection messageDirection;
  final MessageType messageType;
  final String? attachment;
  final String fromUid;
  final String toUid;

  MessageModel({
    required this.createdAt,
    this.text,
    required this.messageDirection,
    required this.messageType,
    this.attachment,
    required this.fromUid,
    required this.toUid,
  });

  Map<String, dynamic> toJson() {
    var direction =
        messageDirection == MessageDirection.sent ? "sent" : "recieved";
    return {
      "createdAt": (createdAt.millisecondsSinceEpoch / 1000).round(),
      "text": text,
      "messageDirection": direction,
      "messageType": messageType.toString().replaceAll("MessageType.", ""),
      "attachment": attachment,
      "fromUid": fromUid,
      "toUid": toUid,
    };
  }

  Map<String, dynamic> toJsonReverse() {
    var direction =
        messageDirection == MessageDirection.recieved ? "sent" : "recieved";
    return {
      "createdAt": (createdAt.millisecondsSinceEpoch / 1000).round(),
      "text": text,
      "messageDirection": direction,
      "messageType": messageType.toString().replaceAll("MessageType.", ""),
      "attachment": attachment,
      "fromUid": fromUid,
      "toUid": toUid,
    };
  }

  static MessageModel fromJson(Map<String, dynamic> json) {
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
    return MessageModel(
      createdAt: time,
      messageDirection: json["messageDirection"] == "sent"
          ? MessageDirection.sent
          : MessageDirection.recieved,
      messageType: MessageType.values.firstWhere(
          (e) => e.toString() == "MessageType." + json["messageType"]),
      fromUid: json["fromUid"],
      toUid: json["toUid"],
      text: json["text"],
      attachment: json["attachment"],
    );
  }
}
