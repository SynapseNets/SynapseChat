//temporary class for conversation, just for building the UI

class Conversation {

  Conversation({
    this.receiver,
    this.lastMessage,
    this.lastMessageTime,
  });

  final String? receiver;
  final String? lastMessage;
  final String? lastMessageTime;

  @override
  Map<String, String> toMap() {
    return {
      'receiver': receiver!,
      'lastMessage': lastMessage!,
      'lastMessageTime': lastMessageTime!,
    };
  }

  Map<String, String> prepareDb() {
    return {
      'name': receiver!,
    };
  }
}