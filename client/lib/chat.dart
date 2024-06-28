import 'package:client/utils/db.dart';
import 'package:flutter/material.dart';
import 'chat/sidebar.dart';
import 'chat/content.dart';
import 'package:client/chat/chatcontroller.dart';
import 'package:get/get.dart';
import 'package:client/chat/messagenotifier.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  bool _chatFocus = false; //mobile toggle option
  double? _lastWidth;
  final ChatController currentChatController = Get.put(ChatController());
  final MessageNotifier messageNotifier = MessageNotifier();

  @override
  Widget build(BuildContext context) {
    _lastWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        // App bar title
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'SynapseChat',
              style: TextStyle(
                fontSize: 30,
                color: Color(0xff3b28cc)
              ),
              ), // Text on the left
            Row(
              children: [
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
                    _chatFocus = !_chatFocus;
                  }),
                  icon: const Icon(Icons.chat),
                ),
                IconButton(
                  onPressed: () => setState(() {
                    Navigator.pushNamed(context, '/settings');
                  }),
                  icon: const Icon(Icons.settings),
                ),
              ],
            ),
          ],
        ),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Builder(
              builder: (context) {
                return !_chatFocus || MediaQuery.of(context).size.width > 600
                    ? Expanded(child: Sidebar(currentChatController: currentChatController, messageNotifier: messageNotifier,))
                    : const SizedBox(width: 0);
              },
            ),
            Builder(builder: (context) {
              return _chatFocus || MediaQuery.of(context).size.width > 600
                  ? Expanded(child: Content(currentChatController: currentChatController, messageNotifier: messageNotifier,))
                  : const SizedBox(width: 0);
            }),
          ],
        ),
      ),
    );
  }
}
