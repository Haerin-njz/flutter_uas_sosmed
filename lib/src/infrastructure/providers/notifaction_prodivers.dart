import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Minimal model matching what NotificationsScreen expects.
class NotificationItem {
  final String? userId;
  final String title;
  final String body;
  final DateTime createdAt;

  NotificationItem({
    this.userId,
    required this.title,
    required this.body,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}

/// Provides a list of notifications. Replace this simulated fetch with your real repository/service.
final notificationsProvider = FutureProvider<List<NotificationItem>>((ref) async {
  try {
    await Future.delayed(const Duration(milliseconds: 300)); // simulate latency
    return [
      NotificationItem(
        userId: 'user_0',
        title: 'Welcome',
        body: 'Thanks for joining the app!',
        createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
      NotificationItem(
        userId: 'user_1',
        title: 'New follower',
        body: 'Alice started following you.',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      NotificationItem(
        userId: 'user_2',
        title: 'Comment',
        body: 'Nice photo!',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];
  } catch (e) {
    throw Exception('Failed to load notifications: $e');
  }
});
