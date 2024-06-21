import 'package:flutter/material.dart';
import 'chat/sidebar.dart';
import 'chat/content.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  bool _chatFocus = false; //mobile toggle option
  double? _lastWidth;

  @override
  Widget build(BuildContext context) {
    _lastWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          //temporary appBar
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () => setState(() {
                      Navigator.pushNamed(context, '/serverconnect');
                    }),
                icon: const Icon(Icons.add)),
            IconButton(
                onPressed: () => setState(() {
                      _chatFocus = !_chatFocus;
                    }),
                icon: const Icon(Icons.chat)),
            IconButton(
                onPressed: () => setState(() {
                      Navigator.pushNamed(context, '/settings');
                    }),
                icon: const Icon(Icons.settings))
          ],
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
                      ? const Expanded(child: Sidebar())
                      : const SizedBox(width: 0);
                },
              ),
              Builder(builder: (context) {
                return _chatFocus || MediaQuery.of(context).size.width > 600
                    ? const Expanded(child: Content())
                    : const SizedBox(width: 0);
              })
            ],
          ),
        ));
  }
}
