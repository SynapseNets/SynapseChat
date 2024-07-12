import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class WebSocketProvider with ChangeNotifier {
  WebSocketChannel? _channel;
  List<String> _messages = [];

  List<String> get messages => _messages;

  void connect(String url) {
    _channel = WebSocketChannel.connect(Uri.parse('ws://localhost:8765'));
    
    _channel!.stream.listen(
      (message) {
        print(message);
        _messages.add(message);
        notifyListeners();
      },
      onDone: () {
        print('Connessione chiusa dal server');
      },
      onError: (error) {
        print('Errore: $error');
      },
    );
  }

  void sendMessage(String message) {
    _channel!.sink.add(message);
  }

  void closeConnection() {
    _channel!.sink.close(status.goingAway);
  }
}
