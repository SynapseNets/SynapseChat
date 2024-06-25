import 'package:flutter/material.dart';
import 'conversation.dart';
import 'chatbutton.dart';
import 'package:client/chat/chatcontroller.dart';
import 'package:client/utils/db.dart';

class Sidebar extends StatefulWidget {
  final ChatController currentChatController;

  const Sidebar({
    super.key,
    required this.currentChatController,
  });

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  List<Conversation> conversations = List.empty();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Conversation>>(
        future: getConversations(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            conversations = snapshot.data!;

            return ListView.builder(
              itemCount: conversations.length,
              itemBuilder: (context, index) {
                Conversation conversation = conversations[index];
                return ChatButton(
                    title: conversation.receiver!,
                    lastMessage: conversation.lastMessage!,
                    time: conversation.lastMessageTime!,
                    onPressed: () {
                      widget.currentChatController
                          .change(conversation.receiver!);
                    });
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
