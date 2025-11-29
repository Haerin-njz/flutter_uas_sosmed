class Message {
  final String id;
  final String conversationId;
  final String senderId;
  final String text;
  final DateTime sentAt;

  Message({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.text,
    required this.sentAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'conversationId': conversationId,
    'senderId': senderId,
    'text': text,
    'sentAt': sentAt.toIso8601String(),
  };

  factory Message.fromJson(Map<String, dynamic> j) => Message(
    id: j['id'] as String,
    conversationId: j['conversationId'] as String,
    senderId: j['senderId'] as String,
    text: j['text'] as String,
    sentAt: DateTime.parse(j['sentAt'] as String),
  );
}

class Conversation {
  final String id;
  final List<String> participantIds;
  final String lastMessagePreview;
  final DateTime lastMessageAt;

  Conversation({
    required this.id,
    required this.participantIds,
    required this.lastMessagePreview,
    required this.lastMessageAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'participantIds': participantIds,
    'lastMessagePreview': lastMessagePreview,
    'lastMessageAt': lastMessageAt.toIso8601String(),
  };

  factory Conversation.fromJson(Map<String, dynamic> j) => Conversation(
    id: j['id'] as String,
    participantIds: List<String>.from(j['participantIds'] as List<dynamic>),
    lastMessagePreview: j['lastMessagePreview'] as String,
    lastMessageAt: DateTime.parse(j['lastMessageAt'] as String),
  );
}
