import 'package:flutter/material.dart';
import 'conversation.dart';
import 'chatbutton.dart';
import 'package:client/chat/chatcontroller.dart';
import 'package:client/utils/db.dart';
import 'package:client/chat/messagenotifier.dart';
import 'package:client/chat/chatfocus.dart';

class Sidebar extends StatefulWidget {
  final ChatController currentChatController;
  final MessageNotifier messageNotifier;
  final ChatFocus chatFocus;

  const Sidebar(
      {super.key,
      required this.currentChatController,
      required this.messageNotifier,
      required this.chatFocus});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  List<Conversation> conversations = List.empty();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: widget.messageNotifier,
        builder: (BuildContext context, Widget? child) {
          return FutureBuilder<List<Conversation>>(
              future: getConversations(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  conversations = snapshot.data!;

                  return ListView.builder(
                    itemCount: conversations.length,
                    itemBuilder: (context, index) {
                      Conversation conversation = conversations[index];
                      return Column(
                        children: [
                          ChatButton(
                              title: conversation.receiver,
                              lastMessage: conversation.lastMessage.length > 20
                                  ? "${conversation.lastMessage.substring(0, 20)}..."
                                  : conversation.lastMessage,
                              time: conversation.lastMessageTime
                                  .toString()
                                  .substring(0, 19),
                              onPressed: () {
                                widget.chatFocus.toggleChatFocus();
                                widget.currentChatController
                                    .change(conversation.receiver);
                              }),
                          const Divider(
                            color: Color(0xff1b2a41),
                            thickness: 0.5,
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              });
        });
  }
}
