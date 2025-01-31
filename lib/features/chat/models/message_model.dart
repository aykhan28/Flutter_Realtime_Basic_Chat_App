import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String sender;
  String text;
  Timestamp timestamp;

  Message({required this.sender, required this.text, required this.timestamp});

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        sender: json['sender'],
        text: json['text'],
        timestamp: json['timestamp'],
      );

  Map<String, dynamic> toJson() => {
        'sender': sender,
        'text': text,
        'timestamp': timestamp,
      };
}