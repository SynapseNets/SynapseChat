import 'package:flutter/foundation.dart';

class ChatFocus with ChangeNotifier {
  bool _chatFocus = false;

  bool get chatFocus => _chatFocus;

  void toggleChatFocus() {
    _chatFocus = !_chatFocus;
    notifyListeners();
  }
}