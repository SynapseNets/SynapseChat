import 'package:get/get.dart';

class ChatController extends GetxController {
  final RxString _currentChat = ''.obs;

  String get currentChat => _currentChat.value;

  void change(String chat){
    _currentChat.value = chat;
  }
}