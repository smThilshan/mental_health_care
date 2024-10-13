import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? body;
  String? userId;
  bool? currentUser;
  DateTime? time;
  String? messageId; // Add the messageId field

  MessageModel({
    this.body,
    this.userId,
    this.currentUser,
    this.time,
    this.messageId, // Initialize the messageId in the constructor
  });

  // Convert MessageModel to a Map for serialization
  Map<String, dynamic> toJson() {
    return {
      'body': body,
      'userId': userId,
      'currentUser': currentUser,
      'time': time != null ? Timestamp.fromDate(time!) : null,
      'messageId': messageId, // Add messageId to the map
    };
  }

  // Create a MessageModel instance from a Map received from JSON
  static MessageModel fromJson(Map<String, dynamic> json) {
    return MessageModel(
      body: json['body'],
      userId: json['userId'],
      currentUser: json['currentUser'],
      time: json['time'] != null ? (json['time'] as Timestamp).toDate() : null,
      messageId: json['messageId'], // Extract messageId from the json map
    );
  }
}
