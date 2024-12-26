import 'package:hive_flutter/hive_flutter.dart';
import '../models/class.dart';
import '../models/feedback.dart';
import '../models/notification.dart';
import '../models/session.dart';
import '../models/qr_code.dart';
import '../models/system_setting.dart';
import '../models/audit_log.dart';
import '../models/attendance.dart';
import '../models/user.dart';
import '../utils/security_utils.dart'; // Import SecurityUtils

class HiveService {
  static Future<void> initializeHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ClassAdapter());
    Hive.registerAdapter(FeedbackAdapter());
    Hive.registerAdapter(NotificationAdapter());
    Hive.registerAdapter(SessionAdapter());
    Hive.registerAdapter(QRCodeAdapter());
    Hive.registerAdapter(SystemSettingAdapter());
    Hive.registerAdapter(AuditLogModelAdapter());
    Hive.registerAdapter(AttendanceModelAdapter());
    Hive.registerAdapter(UserModelAdapter());
  }

  Future<Box<Class>> openClassBox() async {
    return await Hive.openBox<Class>('classes');
  }

  Future<Box<Feedback>> openFeedbackBox() async {
    return await Hive.openBox<Feedback>('feedback');
  }

  Future<Box<Notification>> openNotificationBox() async {
    return await Hive.openBox<Notification>('notifications');
  }

  Future<Box<Session>> openSessionBox() async {
    return await Hive.openBox<Session>('sessions');
  }

  Future<Box<QRCode>> openQRCodeBox() async {
    return await Hive.openBox<QRCode>('qrcodes');
  }

  Future<Box<SystemSetting>> openSystemSettingBox() async {
    return await Hive.openBox<SystemSetting>('systemSettings');
  }

  Future<Box<AuditLogModel>> openAuditLogBox() async {
    return await Hive.openBox<AuditLogModel>('auditLogs');
  }

  Future<Box<AttendanceModel>> openAttendanceBox() async {
    return await Hive.openBox<AttendanceModel>('attendance');
  }

  static Future<Box<UserModel>> openUserBox() async {
    return await Hive.openBox<UserModel>('users');
  }

  Future<void> initializeUsers() async {
    var userBox = await Hive.openBox<UserModel>('users');
    if (userBox.isEmpty) {
      await userBox.add(UserModel(
        userId: 'admin',
        name: 'Admin User',
        email: 'admin@example.com',
        username: 'admin',
        passwordHash: SecurityUtils.hashPassword('admin123'), // Hash password before saving
        role: 'admin',
      ));
      await userBox.add(UserModel(
        userId: 'lecturer1',
        name: 'Lecturer One',
        email: 'lecturer1@example.com',
        username: 'lecturer1',
        passwordHash: SecurityUtils.hashPassword('lecturer123'), // Hash password before saving
        role: 'lecturer',
      ));
      await userBox.add(UserModel(
        userId: 'student1',
        name: 'Student One',
        email: 'student1@example.com',
        username: 'student1',
        passwordHash: SecurityUtils.hashPassword('student123'), // Hash password before saving
        role: 'student',
      ));
    }
  }

  // Save QRCode object to Hive
  Future<void> saveQRCode(QRCode qrCode) async {
    var qrCodeBox = await openQRCodeBox(); // Open the QRCode box
    await qrCodeBox.put(qrCode.qrCodeId, qrCode); // Save the QRCode object with its ID as the key
  }
}
