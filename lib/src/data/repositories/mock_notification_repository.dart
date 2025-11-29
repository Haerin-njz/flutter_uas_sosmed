import 'dart:async';
import '../../data/models/notification_model.dart';
import '../../domain/repositories/notification_repository.dart';

class MockNotificationRepository implements NotificationRepository {
  @override
  Future<List<AppNotification>> fetchNotifications({int limit = 50}) async {
    // simulate network delay
    await Future.delayed(Duration(milliseconds: 300));

    final now = DateTime.now();
    return List.generate(
      limit.clamp(0, 100),
      (i) => AppNotification(
        id: 'notif_$i',
        title: i % 3 == 0 ? 'New follower' : (i % 3 == 1 ? 'New like' : 'New comment'),
        body: i % 3 == 0
            ? 'Someone started following you'
            : (i % 3 == 1 ? 'Someone liked your post' : 'Someone commented on your post'),
        createdAt: now.subtract(Duration(minutes: i * 5)),
        userId: 'user_${i % 8}',
      ),
    );
  }
}
