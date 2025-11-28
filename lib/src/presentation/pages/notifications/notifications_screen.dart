import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uas/data/dummy_data.dart';
import 'package:uas/src/infrastructure/providers/notification_providers.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(notificationsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: async.when(
        data: (items) => ListView.separated(
          padding: EdgeInsets.all(12),
          itemCount: items.length,
          separatorBuilder: (_, __) => Divider(color: Colors.grey[800]),
          itemBuilder: (context, i) {
            final n = items[i];
            final idx = int.tryParse(n.userId?.split('_').last ?? '0') ?? 0;
            final user = dummyUsers[idx % dummyUsers.length];
            return ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl)),
              title: Text(n.title, style: TextStyle(color: Colors.white)),
              subtitle: Text(n.body, style: TextStyle(color: Colors.grey[400])),
              trailing: Text(_timeAgo(n.createdAt), style: TextStyle(color: Colors.grey[500], fontSize: 12)),
            );
          },
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error', style: TextStyle(color: Colors.white))),
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
