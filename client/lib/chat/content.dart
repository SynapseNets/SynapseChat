import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'message.dart';
import 'package:client/utils/db.dart';

class Content extends StatefulWidget {
  const Content({super.key});

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  Duration duration = const Duration(seconds: 30);
  Duration position = const Duration(seconds: 0);

  final TextEditingController _message = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Message> messages = List.empty();

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      FutureBuilder<List<Message>>(future: retrieveMessage('me'), builder: (context, snapshot){
        if (snapshot.hasData) {
              messages = snapshot.data!;
              
              return ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        physics: const BouncingScrollPhysics(),
        itemCount: messages.length + 1,
        itemBuilder: (context, index) {
          if (index == messages.length) {
            return const SizedBox(height: 100);
          }

          Message message = messages[index];
          switch (message.type) {
            case MessageType.text:
              return BubbleNormal(
                padding: const EdgeInsets.all(4),
                text: message.text,
                isSender: message.sender == 'me',
                color: message.sender == 'me'
                    ? const Color(0xff3b28cc)
                    : const Color(0xff1b2a41),
                textStyle: TextStyle(
                  fontSize: 16,
                  color: message.sender == 'me' ? Colors.black : Colors.white,
                ),
                tail: true,
                sent: message.status == MessageStatus.sent,
                delivered: message.status == MessageStatus.delivered,
                seen: message.status == MessageStatus.seen,
              );
            case MessageType.image || MessageType.video:
              return SizedBox(
                  height: 256,
                  child: BubbleNormalImage(
                    id: message.text,
                    image: Image.asset('images/default_profile.png'),
                    isSender: message.sender == 'me',
                    color: message.sender == 'me'
                        ? const Color(0xff3b28cc)
                        : const Color(0xff1b2a41),
                    tail: true,
                    sent: message.status == MessageStatus.sent,
                    delivered: message.status == MessageStatus.delivered,
                    seen: message.status == MessageStatus.seen,
                  ));
            case MessageType.audio:
              return BubbleNormalAudio(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width *
                      (Theme.of(context).platform == TargetPlatform.android ||
                              Theme.of(context).platform == TargetPlatform.iOS
                          ? 0.7
                          : 0.4),
                  maxHeight: 65,
                ),
                duration: duration.inSeconds
                    .toDouble(), //TODO: add changeable duration
                position: position.inSeconds.toDouble(), //TODO: same as above
                onSeekChanged: (value) {
                  setState(() {
                    position = Duration(seconds: value.toInt());
                  });
                },
                onPlayPauseButtonClick: () => print('Play/Pause'),
                isSender: message.sender == 'me',
                color: message.sender == 'me'
                    ? const Color(0xff3b28cc)
                    : const Color(0xff1b2a41),
                tail: true,
                sent: message.status == MessageStatus.sent,
                delivered: message.status == MessageStatus.delivered,
                seen: message.status == MessageStatus.seen,
              );
            case MessageType.file:
              return BubbleNormal(
                text: message.text,
                isSender: message.sender == 'me',
                color: message.sender == 'me'
                    ? const Color(0xff3b28cc)
                    : const Color(0xff1b2a41),
                tail: true,
                sent: message.status == MessageStatus.sent,
                delivered: message.status == MessageStatus.delivered,
                seen: message.status == MessageStatus.seen,
              );
          }
        },
      );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              return const Text("Error");
            }
      }),
      Container(
        // Bottom bar
        alignment: Alignment.bottomCenter,
        child: SizedBox(
            child: Container(
                color: Theme.of(context).colorScheme.surface,
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _message,
                        decoration: const InputDecoration(
                          hintText: 'Type a message',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (_message.text.isEmpty ||
                              _message.text.trim().isEmpty) {
                            _message.clear();
                            return;
                          }

                          insertMessage(Message(
                            text: _message.text,
                            time: DateTime.now(),
                            type: MessageType.text,
                            sender: 'me',
                          ));
                          _message.clear();
                          _scrollController.animateTo(
                              _scrollController.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.fastEaseInToSlowEaseOut);
                        });
                      },
                      icon: const Icon(Icons.send),
                    ),
                  ],
                ))),
      )
    ]);
  }
}
