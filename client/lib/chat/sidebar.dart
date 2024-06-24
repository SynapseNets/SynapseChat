import 'package:flutter/material.dart';
import 'conversation.dart';
import 'chatbutton.dart';

final List<Conversation> conversations = [
  Conversation(
    receiver: 'John Doe',
    lastMessage: 'Hello, how are you?',
    lastMessageTime: '10:00 AM',
  ),
  Conversation(
    receiver: 'Jane Doe',
    lastMessage: 'I am fine, thank you.',
    lastMessageTime: '10:01 AM',
  ),
  Conversation(
    receiver: 'John Dingo',
    lastMessage: 'What are you doing?',
    lastMessageTime: '10:02 AM',
  ),
  Conversation(
    receiver: 'Jane Dingo',
    lastMessage: 'I am working on a project.',
    lastMessageTime: '10:03 AM',
  ),
  Conversation(
    receiver: 'Al Doe',
    lastMessage: 'Can I help you?',
    lastMessageTime: '10:04 AM',
  ),
  Conversation(
    receiver: 'Moe Rou',
    lastMessage: 'No, thank you.',
    lastMessageTime: '10:05 AM',
  ),
];

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: conversations.length,
      itemBuilder: (context, index) {
        Conversation conversation = conversations[index];
        return ChatButton(title: conversation.receiver!, lastMessage: conversation.lastMessage!, time: conversation.lastMessageTime!, onPressed: () {} ); //TODO add logic
      },
    );
  }
}
