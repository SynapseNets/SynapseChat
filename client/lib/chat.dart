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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar( //temporary appBar
        actions: [
          IconButton(onPressed: () => setState(() {_chatFocus = !_chatFocus;}), icon: const Icon(Icons.chat))
        ],
      ),
        body: NotificationListener<SizeChangedLayoutNotification>(
      onNotification: (notification) {
        setState(() {});
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
