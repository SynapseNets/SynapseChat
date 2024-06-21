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
    return Stack(children: [
      ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          Message message = messages[index];
          return BubbleNormal(
            text: message.text,
            isSender: message.isSender,
            color: message.isSender
                ? const Color(0xff3b28cc)
                : const Color(0xff1b2a41),
            textStyle: TextStyle(
              fontSize: 18,
              color: message.isSender ? Colors.black : Colors.white,
            ),
            tail: true,
            sent: true,
            seen: true,
          );
        },
      ),
      MessageBar(
        sendButtonColor: const Color(0xff3b28cc),
        messageBarColor: Theme.of(context).colorScheme.primary,
        onSend: (_) => print(_),
        actions: [
        InkWell(
          child: const Icon(
            Icons.add,
            color: Colors.black,
            size: 24,
          ),
          onTap: () {},
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: InkWell(
            child: const Icon(
              Icons.camera_alt,
              color: Color(0xff3b28cc),
              size: 24,
            ),
            onTap: () {},
          ),
        ),
      ])
    ]);
  }
}
