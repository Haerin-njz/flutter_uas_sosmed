import 'dart:async';

import '../../domain/entities/message.dart';
import '../../../data/dummy_data.dart';
import '../../infrastructure/storage/message_storage.dart';

class MockMessageRepository {
  final Map<String, List<Message>> _store = {};

  MockMessageRepository() {
    // seed 8 conversations
    final now = DateTime.now();
    for (var i = 0; i < 8; i++) {
      final convId = 'conv_$i';
      final otherA = dummyUsers[i % dummyUsers.length];
      final otherB = dummyUsers[(i + 1) % dummyUsers.length];
      final messages = List.generate(6, (m) {
        return Message(
          id: '$convId-msg_$m',
          conversationId: convId,
          senderId: (m % 2 == 0) ? otherA.id : otherB.id,
          text:
              'Hello from ${m % 2 == 0 ? otherA.username : otherB.username} — message #$m',
          sentAt: now.subtract(Duration(minutes: m * 3 + i)),
        );
      });
      _store[convId] = messages;
    }
    // Try load persisted messages and merge where present
    _loadPersisted();
  }

  Future<void> _loadPersisted() async {
    for (final convId in List<String>.from(_store.keys)) {
      final persisted = await MessageStorage.loadMessages(convId);
      if (persisted.isNotEmpty) {
        _store[convId] = persisted;
      }
    }
  }

  Future<List<Conversation>> fetchConversations() async {
    await Future.delayed(Duration(milliseconds: 200));
    return _store.entries.map((entry) {
      final id = entry.key;
      final msgs = entry.value;
      final last = msgs.isNotEmpty ? msgs.last : null;
      return Conversation(
        id: id,
        participantIds: [msgs.first.senderId, msgs.last.senderId],
        lastMessagePreview: last?.text ?? '',
        lastMessageAt: last?.sentAt ?? DateTime.now(),
      );
    }).toList();
  }

  Future<List<Message>> fetchMessagesForConversation(
    String conversationId,
  ) async {
    await Future.delayed(Duration(milliseconds: 120));
    return List.from(_store[conversationId] ?? []);
  }

  Future<void> addMessage(String conversationId, Message message) async {
    _store.putIfAbsent(conversationId, () => []);
    _store[conversationId]!.add(message);
    await MessageStorage.saveMessages(conversationId, _store[conversationId]!);
    // no network delay for local append
  }
}
