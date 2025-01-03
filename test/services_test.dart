import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import '../lib/services/admin_service.dart';
import '../lib/models/admin.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive in test mode
  Hive.init('./test_hive');
  Hive.registerAdapter(AdminAdapter());
  var adminBox = await Hive.openBox<Admin>('admins');

  // Create an instance of AdminService
  var adminService = AdminService(adminBox, null, null, null);

  group('AdminService Tests', () {
    test('Create and Get Admin', () async {
      var admin = Admin(id: '1', name: 'Admin One', email: 'admin1@example.com');
      await adminService.createAdmin(admin);

      var fetchedAdmin = adminService.getAdmin('1');
      expect(fetchedAdmin?.name, 'Admin One');
      expect(fetchedAdmin?.email, 'admin1@example.com');
    });

    test('Update Admin', () async {
      var admin = Admin(id: '1', name: 'Updated Admin', email: 'updated@example.com');
      await adminService.updateAdmin(admin);

      var fetchedAdmin = adminService.getAdmin('1');
      expect(fetchedAdmin?.name, 'Updated Admin');
    });

    test('Delete Admin', () async {
      await adminService.deleteAdmin('1');
      var fetchedAdmin = adminService.getAdmin('1');
      expect(fetchedAdmin, null);
    });
  });

  tearDownAll(() async {
    await adminBox.clear();
    await Hive.close();
  });
}
