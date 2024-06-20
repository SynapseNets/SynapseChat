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
}