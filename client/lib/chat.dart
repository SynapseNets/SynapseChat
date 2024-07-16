import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'chat/sidebar.dart';
import 'chat/content.dart';
import 'package:client/chat/chatcontroller.dart';
import 'package:get/get.dart';
import 'package:client/chat/messagenotifier.dart';
import 'package:client/chat/chatfocus.dart';
import 'package:client/utils/settings_preferences.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final ChatFocus _chatFocus = ChatFocus(); // mobile toggle option
  double? _lastWidth;
  final ChatController currentChatController = Get.put(ChatController());
  final MessageNotifier messageNotifier = MessageNotifier();
  Color? backgroundColor = const Color(4287002859);

  void loadPreferences() {
    Future.wait([
      SettingsPreferences.getBackgroundColor(),
    ]).then((values) {
      setState(() {
        backgroundColor = Color(values[0]);
      });
    }).catchError((error) {
      print('Error loading preferences: $error');
    });
  }

  @override
  void initState() {
    super.initState();
    loadPreferences();
  }

  @override
  Widget build(BuildContext context) {
    _lastWidth = MediaQuery.of(context).size.width;

    print(backgroundColor);
    return Scaffold(
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
                            child: Scaffold(
                              appBar: AppBar(
                                toolbarHeight: 60,
                                backgroundColor: const Color(0xFF0A121D),
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ListenableBuilder(
                                      listenable: _chatFocus,
                                      builder: (context, child) {
                                        return _chatFocus.chatFocus &&
                                                MediaQuery.of(context)
                                                        .size
                                                        .width <=
                                                    600
                                            ? IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _chatFocus
                                                        .toggleChatFocus();
                                                  });
                                                },
                                                icon: const Icon(Icons.menu),
                                              )
                                            : const SizedBox(width: 0);
                                      },
                                    ),
                                    const Text(
                                      'SynapseChat',
                                      style: TextStyle(
                                          fontSize: 30,
                                          color: Color(0xFF232A80)),
                                    ), // Text on the left
                                  ],
                                ),
                                actions: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'images/add_server.svg',
                                        width: 33,
                                        height: 33,
                                        fit: BoxFit.cover,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, '/serverconnect');
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          shadowColor: Colors.transparent,
                                          padding: EdgeInsets.zero,
                                          shape: const CircleBorder(),
                                        ),
                                        child: const SizedBox(
                                            width: 40, height: 40),
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
                              body: Column(
                                children: [
                                  Divider(
                                    height: 0.5,
                                    thickness: 0.5,
                                    color: Colors.grey.withOpacity(0.5),
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: const Color(
                                          0xFF121212), // Colore di sfondo della sidebar
                                      child: Sidebar(
                                        currentChatController:
                                            currentChatController,
                                        messageNotifier: messageNotifier,
                                        chatFocus: _chatFocus,
                                      ),
                                    ),
                                  ),
                                ],
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
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: SvgPicture.asset(
                                    'images/background_chat.svg',
                                    colorFilter: ColorFilter.mode(
                                        backgroundColor!, BlendMode.color),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Column(
                                  children: [
                                    AppBar(
                                      toolbarHeight: 60,
                                      backgroundColor: const Color(0xFF0A121D),
                                      title: Text(
                                        currentChatController.currentChat,
                                        style: const TextStyle(
                                            fontSize: 30,
                                            color: Color(0xFFFFFFFF)),
                                      ),
                                      actions: [
                                        Builder(builder: (context) {
                                          if (_chatFocus.chatFocus &&
                                              MediaQuery.of(context)
                                                      .size
                                                      .width <=
                                                  730) {
                                            return IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  _chatFocus.toggleChatFocus();
                                                });
                                              },
                                              icon: const Icon(Icons.menu),
                                            );
                                          } else {
                                            return const SizedBox(width: 0);
                                          }
                                        }),
                                      ],
                                      automaticallyImplyLeading: false,
                                    ),
                                    Expanded(
                                      child: Content(
                                        currentChatController:
                                            currentChatController,
                                        messageNotifier: messageNotifier,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
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
