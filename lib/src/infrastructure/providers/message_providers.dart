import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/mock_message_repository.dart';
import '../../domain/entities/message.dart';

final mockMessageRepoProvider = Provider((ref) => MockMessageRepository());

final conversationsProvider = FutureProvider.autoDispose((ref) async {
  final repo = ref.watch(mockMessageRepoProvider);
  return repo.fetchConversations();
});

final messagesProvider = FutureProvider.family.autoDispose<List<Message>, String>((ref, conversationId) async {
  final repo = ref.watch(mockMessageRepoProvider);
  return repo.fetchMessagesForConversation(conversationId);
});
