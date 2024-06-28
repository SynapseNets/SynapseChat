//temporary class for conversation, just for building the UI

class Conversation {

  Conversation({
    required this.receiver,
    required this.lastMessage,
    required this.lastMessageTime,
  });

  final String receiver;
  final String lastMessage;
  final DateTime lastMessageTime;

  Map<String, Object> toMap() {
    return {
      'receiver': receiver,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime,
    };
  }

  Map<String, String> prepareDb() {
    return {
      'name': receiver,
    };
  }
}