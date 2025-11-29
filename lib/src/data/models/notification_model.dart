class AppNotification {
  final String id;
  final String title;
  final String body;
  final DateTime createdAt;
  final String? userId; // who triggered the notification

  AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
    this.userId,
  });
}
