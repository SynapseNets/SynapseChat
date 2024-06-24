import 'dart:ui';
import 'package:path/path.dart';

class Message {
  final String text;
  final DateTime time;
  final MessageType type;
  MessageStatus status = MessageStatus.sent;
  final String sender;
  String? audio;
  Image? image;

  Message({
    required this.text,
    required this.time,
    required this.type,
    required this.sender,
    this.audio,
    this.image,
  });

  Map<String, Object?> toMap(){
    return {
      'text': text,
      'type': type.index,
      'time': time.toIso8601String(),
      'status': status.index,
      'sender': sender,
      'audio': audio?.toString(),
      'image': image?.toString(),
    };
  }

  @override
  String toString() {
    return 'Message: $text, $time, $type, $status, $sender, $audio, $image';
  }

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