import 'package:flutter/material.dart';

class MessageNotifier with ChangeNotifier{
  void notifyMessage(){
    notifyListeners();
  }
}