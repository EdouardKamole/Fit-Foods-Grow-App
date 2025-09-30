class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  Future<void> scheduleNotification(String title, String body, Duration delay) async {
    await Future.delayed(delay);
  }

  Future<void> cancelAllNotifications() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> requestPermissions() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}