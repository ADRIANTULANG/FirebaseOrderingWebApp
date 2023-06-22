// To parse this JSON data, do
//
//     final chatModel = chatModelFromJson(jsonString);

import 'dart:convert';

List<ChatModel> chatModelFromJson(String str) =>
    List<ChatModel>.from(json.decode(str).map((x) => ChatModel.fromJson(x)));

String chatModelToJson(List<ChatModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatModel {
  String id;
  String message;
  String sender;
  DateTime date;
  String orderid;

  ChatModel({
    required this.id,
    required this.message,
    required this.sender,
    required this.orderid,
    required this.date,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        id: json["id"],
        message: json["message"],
        sender: json["sender"],
        orderid: json["orderid"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
        "orderid": orderid,
        "sender": sender,
        "date": date.toIso8601String(),
      };
}
