import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:get/get.dart';
import 'message.dart';
import 'package:client/utils/db.dart';
import 'package:client/chat/chatcontroller.dart';
import 'package:client/chat/messagenotifier.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:client/l10n/app_localizations.dart';

class Content extends StatefulWidget {
  final ChatController currentChatController;
  final MessageNotifier messageNotifier;

  const Content(
      {super.key,
      required this.currentChatController,
      required this.messageNotifier});

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  Duration duration = const Duration(seconds: 30);
  Duration position = const Duration(seconds: 0);

  double _currentSliderValue = 100;

  final TextEditingController _message = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Message> messages = List.empty();

  Future<void> _sendMessage() async {
    if (_message.text.isEmpty || _message.text.trim().isEmpty) {
      setState(() {
        _message.clear();
      });
      return;
    }

    //call for sidebar rebuild
    widget.messageNotifier.notifyMessage();

    if (messages.isNotEmpty &&
        (messages.last.time.day != DateTime.now().day ||
            messages.last.time.month != DateTime.now().month ||
            messages.last.time.year != DateTime.now().year)) {
      await insertMessage(Message(
        text: '',
        time: DateTime.now(),
        type: MessageType.date,
        sender: '',
        name: widget.currentChatController.currentChat,
      ));
    }

    await insertMessage(Message(
      text: _message.text,
      time: DateTime.now(),
      type: MessageType.text,
      sender: 'me',
      name: widget.currentChatController.currentChat,
    ));

    setState(() {
      _message.clear();
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + _currentSliderValue,
        duration: const Duration(milliseconds: 10),
        curve: Curves.easeIn,
      );
    });
  }

  String format(String text){
    if (text.length > 34){
      List<String> words = text.split(' ');

      String result = '';
      String tmp = '';

      words.forEach((element){
          if(tmp.length + element.length > 34){
            //case element is longer than 34
            if(element.length > 34){
              result += tmp.isNotEmpty ? "$tmp\n" : "";
              while(element.length > 34){
                result += "${element.substring(0, 34)}\n";
                element = element.substring(34);
              }
              tmp = element;
          } else {
            //case element is shorter than 34
            result += "$tmp\n";
            tmp = element;
          }
        } else {
            tmp += ' $element';
          }
      });

      result += tmp;
      return result;

    } else {return text;}
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      print(widget.currentChatController.currentChat);
      return Stack(children: [
        
        FutureBuilder<List<Message>>(
            future: retrieveMessage(widget.currentChatController.currentChat),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                messages = snapshot.data!;

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  physics: const BouncingScrollPhysics(),
                  itemCount: messages.length + 1,
                  itemBuilder: (context, index) {

                    if (index == messages.length) {
                      return VisibilityDetector(
                        key: const Key('Bottom'),
                        child: const SizedBox(height: 125),
                        onVisibilityChanged: (info) {
                          _currentSliderValue = info.visibleFraction == 0 ? 125 : 10;
                        });
                    }

                    Message message = messages[index];
                    switch (message.type) {
                      case MessageType.text:
                        return BubbleNormal(
                          padding: const EdgeInsets.all(4),
                          text: MediaQuery.of(context).size.width > 730 ? format(message.text) : message.text,
                          isSender: message.sender == 'me',
                          color: message.sender == 'me'
                              ? const Color(0xff3b28cc)
                              : const Color(0xff1b2a41),
                          textStyle: TextStyle(
                            fontSize: 16,
                            color: message.sender == 'me'
                                ? Colors.black
                                : Colors.white,
                          ),
                          tail: true,
                          sent: message.status == MessageStatus.sent,
                          delivered: message.status == MessageStatus.delivered,
                          seen: message.status == MessageStatus.seen,
                        );
                      case MessageType.image:
                      case MessageType.video:
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
                          ),
                        );
                      case MessageType.audio:
                        return BubbleNormalAudio(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width *
                                (Theme.of(context).platform ==
                                            TargetPlatform.android ||
                                        Theme.of(context).platform ==
                                            TargetPlatform.iOS
                                    ? 0.7
                                    : 0.4),
                            maxHeight: 65,
                          ),
                          duration: duration.inSeconds
                              .toDouble(), //TODO: add changeable duration
                          position: position.inSeconds
                              .toDouble(), //TODO: same as above
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
                      case MessageType.date:
                        return DateChip(date: message.time);
                    }
                  },
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                return const Text("Error");
              }
            }),
        Builder(builder: (context) {
          if (widget.currentChatController.currentChat == '') {
            return Center(
              child: Text(AppLocalizations.of(context).contentPageSelectChatText),
            );
          } else {
            return Container(
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
                              onSubmitted: (value) async {
                                await _sendMessage();
                              },
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              await _sendMessage();
                            },
                            icon: const Icon(Icons.send),
                          ),
                        ],
                      ))),
            );
          }
        }),
        Builder(builder: (context){
          if(widget.currentChatController.currentChat == ''){ return const SizedBox(width: 0,);}
          else{
            return SizedBox(
              height: 50,
              child: AppBar(
                backgroundColor: const Color(0xFF001529),
                automaticallyImplyLeading: false,
                title: Text(widget.currentChatController.currentChat),
            ));
        }}),
      ]);
    });
  }
}
