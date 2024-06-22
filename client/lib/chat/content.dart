import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'message.dart';

List<Message> messages = [
  Message(text: 'Hi', type: MessageType.text, sender: 'not me'),
  Message(text: 'Hello', type: MessageType.text, sender: 'me'),
  Message(text: 'How are you?', type: MessageType.text, sender: 'not me'),
  Message(text: 'I am fine', type: MessageType.text, sender: 'me'),
  Message(text: 'How about you?', type: MessageType.text, sender: 'me'),
  Message(text: 'I am good too', type: MessageType.text, sender: 'not me'),
  Message(text: 'What are you doing?', type: MessageType.text, sender: 'me'),
  Message(text: 'Nothing much', type: MessageType.text, sender: 'not me'),
  Message(text: 'Just chilling', type: MessageType.text, sender: 'not me'),
  Message(text: 'Cool', type: MessageType.text, sender: 'me'),
  Message(text: 'What about you?', type: MessageType.text, sender: 'me'),
  Message(text: 'Same here', type: MessageType.text, sender: 'not me'),
  Message(text: 'I am bored', type: MessageType.text, sender: 'me'),
  Message(text: 'Let\'s go out', type: MessageType.text, sender: 'me'),
  Message(text: 'Where?', type: MessageType.text, sender: 'not me'),
  Message(text: 'To the park', type: MessageType.text, sender: 'me'),
  Message(text: 'Okay', type: MessageType.text, sender: 'not me'),
  Message(
      text: 'I will be there in 10 minutes',
      type: MessageType.text,
      sender: 'me'),
  Message(text: '', type: MessageType.audio, sender: 'me'),
  Message(text: 'Okay', type: MessageType.text, sender: 'not me'),
  Message(text: 'See you soon', type: MessageType.text, sender: 'me'),
  Message(text: 'Bye', type: MessageType.text, sender: 'not me'),
  Message(text: 'Bye', type: MessageType.text, sender: 'me'),
  Message(text: 'Check this out', type: MessageType.image, sender: 'me'),
  Message(text: 'Bye', type: MessageType.text, sender: 'not me'),
  Message(text: 'Bye', type: MessageType.text, sender: 'me'),
  Message(text: 'Bye', type: MessageType.text, sender: 'not me'),
];

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

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ListView.builder(
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
                  maxWidth: MediaQuery.of(context).size.width * 0.4,
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
      ),
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              messages.add(Message(
                                  text: _message.text,
                                  type: MessageType.text,
                                  sender: 'me'));
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
