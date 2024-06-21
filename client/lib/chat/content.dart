import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'message.dart';

List<Message> messages = [
  Message(isSender: false, text: 'Hello!', time: DateTime.now()),
  Message(isSender: true, text: 'Hi!', time: DateTime.now()),
  Message(isSender: false, text: 'How are you?', time: DateTime.now()),
  Message(isSender: true, text: 'I am fine.', time: DateTime.now()),
  Message(isSender: false, text: 'What are you doing?', time: DateTime.now()),
  Message(isSender: true, text: 'Nothing much.', time: DateTime.now()),
  Message(isSender: false, text: 'Okay.', time: DateTime.now()),
  Message(isSender: true, text: 'Bye!', time: DateTime.now()),
  Message(isSender: false, text: 'Goodbye!', time: DateTime.now()),
];

class Content extends StatefulWidget {
  const Content({super.key});

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        Message message = messages[index];
        return BubbleSpecialOne(
          text: message.text,
          isSender: message.isSender,
          color: message.isSender ? Color(0xffFFC107) : Color(0xffE0E0E0),
          textStyle: TextStyle(
            fontSize: 18,
            color: message.isSender ? Colors.black : Colors.black,
          ),
          tail: true,
        );
      },
    );
  }
}