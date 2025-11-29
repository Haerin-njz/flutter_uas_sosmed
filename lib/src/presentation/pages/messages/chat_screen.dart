import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uas/src/domain/entities/message.dart';
import 'package:uas/src/infrastructure/providers/message_providers.dart';
import 'package:uas/data/dummy_data.dart';
import 'package:uas/src/infrastructure/providers/auth_state_provider.dart';

class ChatScreen extends ConsumerWidget {
  final Conversation conversation;

  const ChatScreen({super.key, required this.conversation});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(messagesProvider(conversation.id));

    final me = ref.watch(authStateProvider);
    final myId = me?.id ?? '';

    final otherId = conversation.participantIds.firstWhere(
      (id) => id != myId,
      orElse: () => conversation.participantIds.first,
    );
    final other = dummyUsers.firstWhere((u) => u.id == otherId);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(backgroundImage: NetworkImage(other.avatarUrl)),
            SizedBox(width: 8),
            Text(other.displayName),
          ],
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: async.when(
        data: (messages) => Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                padding: EdgeInsets.all(12),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final m = messages[messages.length - 1 - index];
                  final isMe = m.senderId == myId;
                  return Align(
                    alignment: isMe
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 6),
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 14,
                      ),
                      decoration: BoxDecoration(
                        color: isMe ? Colors.blueAccent : Colors.grey[850],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        m.text,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
            _Composer(conversationId: conversation.id),
          ],
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(
          child: Text('Error', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}

class _Composer extends ConsumerStatefulWidget {
  final String conversationId;

  const _Composer({required this.conversationId});

  @override
  __ComposerState createState() => __ComposerState();
}

class __ComposerState extends ConsumerState<_Composer> {
  final _ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        color: Colors.black,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _ctrl,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Message',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[900],
                ),
              ),
            ),
            SizedBox(width: 8),
            IconButton(
              icon: Icon(Icons.send, color: Colors.blueAccent),
              onPressed: () async {
                final text = _ctrl.text.trim();
                if (text.isEmpty) return;
                final repo = ref.read(mockMessageRepoProvider);
                final me = ref.read(authStateProvider);
                final msg = Message(
                  id: '${widget.conversationId}-msg-${DateTime.now().millisecondsSinceEpoch}',
                  conversationId: widget.conversationId,
                  senderId: me?.id ?? dummyUsers[0].id,
                  text: text,
                  sentAt: DateTime.now(),
                );
                await repo.addMessage(widget.conversationId, msg);
                // refresh provider to fetch latest messages
                ref.invalidate(messagesProvider(widget.conversationId));
                _ctrl.clear();
              },
            ),
          ],
        ),
      ),
    );
  }
}
