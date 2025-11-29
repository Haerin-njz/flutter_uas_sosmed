import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uas/data/dummy_data.dart';
import 'package:uas/src/infrastructure/providers/auth_state_provider.dart';
import 'package:uas/src/infrastructure/providers/message_providers.dart';
import 'package:uas/src/presentation/pages/messages/chat_screen.dart';

class ConversationsScreen extends ConsumerWidget {
  const ConversationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(conversationsProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Messages'), backgroundColor: Colors.black),
      backgroundColor: Colors.black,
      body: async.when(
        data: (items) => ListView.separated(
          padding: EdgeInsets.all(12),
          itemCount: items.length,
          separatorBuilder: (_, __) => Divider(color: Colors.grey[800]),
          itemBuilder: (context, i) {
            final c = items[i];
            final me = ref.watch(authStateProvider);
            final myId = me?.id ?? '';
            final otherId = c.participantIds.firstWhere(
              (id) => id != myId,
              orElse: () => c.participantIds.first,
            );
            final other = dummyUsers.firstWhere((u) => u.id == otherId);
            return ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundImage: NetworkImage(other.avatarUrl),
              ),
              title: Text(
                other.displayName,
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                c.lastMessagePreview,
                style: TextStyle(color: Colors.grey[400]),
              ),
              trailing: Text(
                _timeAgo(c.lastMessageAt),
                style: TextStyle(color: Colors.grey[500], fontSize: 12),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ChatScreen(conversation: c),
                  ),
                );
              },
            );
          },
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(
          child: Text('Error', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  String _timeAgo(DateTime t) {
    final d = DateTime.now().difference(t);
    if (d.inMinutes < 60) return '${d.inMinutes}m';
    if (d.inHours < 24) return '${d.inHours}h';
    return '${d.inDays}d';
  }
}
