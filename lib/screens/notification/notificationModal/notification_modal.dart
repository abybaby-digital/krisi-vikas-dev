// To parse this JSON data, do
//
//     final notificationListModel = notificationListModelFromJson(jsonString);

import 'dart:convert';

NotificationListModel notificationListModelFromJson(String str) =>
    NotificationListModel.fromJson(json.decode(str));

String notificationListModelToJson(NotificationListModel data) =>
    json.encode(data.toJson());

class NotificationListModel {
  bool response;
  String message;
  List<NotificationList> data;
  String error;

  NotificationListModel({
    required this.response,
    required this.message,
    required this.data,
    required this.error,
  });

  factory NotificationListModel.fromJson(Map<String, dynamic> json) =>
      NotificationListModel(
        response: json["response"],
        message: json["message"],
        data: List<NotificationList>.from(
            json["data"].map((x) => NotificationList.fromJson(x))),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
    "response": response,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "error": error,
  };
}

class NotificationList {
  int id;
  bool read;
  String tiltle;
  String deception;
  String img;
  int languageId;
  int status;
  String dateTime;

  NotificationList({
    required this.id,
    required this.read,
    required this.tiltle,
    required this.deception,
    required this.img,
    required this.languageId,
    required this.status,
    required this.dateTime,
  });

  factory NotificationList.fromJson(Map<String, dynamic> json) =>
      NotificationList(
        id: json["id"],
        read: json['read'] ?? false,
        tiltle: json["tiltle"],
        deception: json["deception"],
        img: json["img"],
        languageId: json["language_id"],
        status: json["status"],
        dateTime: json["date_time"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tiltle": tiltle,
    "deception": deception,
    "img": img,
    'read': read,
    "language_id": languageId,
    "status": status,
    "date_time": dateTime,
  };
}
