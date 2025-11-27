class ChatMessage {
  final String id;
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final MessageType type;

  ChatMessage({
    required this.id,
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.type = MessageType.text,
  });

  factory ChatMessage.user(String text) {
    return ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      isUser: true,
      timestamp: DateTime.now(),
    );
  }

  factory ChatMessage.marsha(String text) {
    return ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      isUser: false,
      timestamp: DateTime.now(),
    );
  }

  factory ChatMessage.typing() {
    return ChatMessage(
      id: 'typing',
      text: '',
      isUser: false,
      timestamp: DateTime.now(),
      type: MessageType.typing,
    );
  }
}

enum MessageType { text, typing, quickAction }

enum MarshaState {
  idle,
  greeting,
  thinking,
  explaining,
  encouraging,
  warning,
  celebrating,
}
