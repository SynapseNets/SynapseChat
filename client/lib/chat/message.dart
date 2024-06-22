import 'dart:ui';

class Message {
  final String text;
  final MessageType type;
  MessageStatus status = MessageStatus.sent;
  final String sender;
  String? audio;
  Image? image;

  Message({
    required this.text,
    required this.type,
    required this.sender,
    this.audio,
    this.image,
  });

  updateStatus(MessageStatus status) {
    this.status = status;
  }
}

enum MessageType {
  text,
  image,
  video,
  audio,
  file,
}

enum MessageStatus {
  sent,
  delivered,
  seen,
}