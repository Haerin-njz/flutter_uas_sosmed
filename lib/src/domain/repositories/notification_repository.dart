import '../../data/models/notification_model.dart';

abstract class NotificationRepository {
  Future<List<AppNotification>> fetchNotifications({int limit = 50});
}
