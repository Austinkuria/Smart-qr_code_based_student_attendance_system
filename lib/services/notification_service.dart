import '../services/hive_service.dart';
import '../models/notification.dart';

class NotificationService {
  static Future<void> addNotification(Notification notification) async {
    final hiveService = HiveService();
    final box = await hiveService.openNotificationBox();
    await box.add(notification);
  }

  static Future<List<Notification>> getNotificationsByUser(String userId) async {
    final hiveService = HiveService();
    final box = await hiveService.openNotificationBox();
    return box.values.where((notification) => notification.userId == userId).toList();
  }

  static Future<void> markNotificationAsRead(String notificationId) async {
    final hiveService = HiveService();
    final box = await hiveService.openNotificationBox();
    final notification = box.values.firstWhere((notification) => notification.notificationId == notificationId);
    notification.readStatus = true;
    await box.put(notification.notificationId, notification);
  }

  static Future<void> deleteNotification(String notificationId) async {
    final hiveService = HiveService();
    final box = await hiveService.openNotificationBox();
    await box.delete(notificationId);
  }
}
