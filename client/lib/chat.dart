import 'package:flutter/material.dart';
import 'chat/sidebar.dart';
import 'chat/content.dart';
import 'package:client/chat/chatcontroller.dart';
import 'package:get/get.dart';
import 'package:client/chat/messagenotifier.dart';
import 'package:client/chat/chatfocus.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final ChatFocus _chatFocus = ChatFocus(); //mobile toggle option
  double? _lastWidth;
  final ChatController currentChatController = Get.put(ChatController());
  final MessageNotifier messageNotifier = MessageNotifier();

  @override
  Widget build(BuildContext context) {
    _lastWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0x00000000),
        // App bar title
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListenableBuilder(
              listenable: _chatFocus,
              builder: (context, child) {
                return _chatFocus.chatFocus &&
                        MediaQuery.of(context).size.width <= 600
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            _chatFocus.toggleChatFocus();
                          });
                        },
                        icon: const Icon(Icons.menu),
                      )
                    : const SizedBox(
                        width: 0,
                      );
              },
            ),
            const Text(
              'SynapseChat',
              style: TextStyle(fontSize: 30, color: Color(0xff191970)),
            ), // Text on the left
          ],
        ),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'images/add_server.png',
                width: 33,
                height: 33,
                fit: BoxFit.cover,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/serverconnect');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: EdgeInsets.zero,
                  shape: const CircleBorder(),
                ),
                child: const SizedBox(width: 40, height: 40),
              ),
            ],
          ),
          IconButton(
            onPressed: () => setState(() {
              Navigator.pushNamed(context, '/settings');
            }),
            icon: const Icon(Icons.settings),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: NotificationListener<SizeChangedLayoutNotification>(
        onNotification: (notification) {
          if (MediaQuery.of(context).size.width != _lastWidth) {
            _lastWidth = MediaQuery.of(context).size.width;
            setState(() {});
          }
          return true;
        },
        child: ListenableBuilder(
          listenable: _chatFocus,
          builder: (context, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Builder(
                  builder: (context) {
                    return !_chatFocus.chatFocus ||
                            MediaQuery.of(context).size.width > 730
                        ? Expanded(
                            child: Container(
                              color: const Color(0xFF121212), // Colore di sfondo della sidebar
                              child: Sidebar(
                                currentChatController: currentChatController,
                                messageNotifier: messageNotifier,
                                chatFocus: _chatFocus,
                              ),
                            ),
                          )
                        : const SizedBox(width: 0);
                  },
                ),
                Builder(
                  builder: (context) {
                    return _chatFocus.chatFocus ||
                            MediaQuery.of(context).size.width > 730
                        ? Expanded(
                            child: Container(
                              decoration:const  BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('images/background_chat.png'), 
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Content(
                                currentChatController: currentChatController,
                                messageNotifier: messageNotifier,
                              ),
                            ),
                          )
                        : const SizedBox(width: 0);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
