import 'package:hive/hive.dart';
import '../models/users/admin.dart';
import '../models/users/student.dart';
import '.../models/users/lecturer.dart';
import '../utils/api_client.dart'; 

class AdminService {
  final Box<Admin> adminBox;
  final Box<Student> studentBox;
  final Box<Lecturer> lecturerBox;
  final ApiClient apiClient;

  AdminService(this.adminBox, this.studentBox, this.lecturerBox, this.apiClient);

  // CRUD Operations
  Future<void> createAdmin(Admin admin) async {
    await adminBox.put(admin.id, admin);
  }

  Admin? getAdmin(String id) {
    return adminBox.get(id);
  }

  Future<void> updateAdmin(Admin admin) async {
    await adminBox.put(admin.id, admin);
  }

  Future<void> deleteAdmin(String id) async {
    await adminBox.delete(id);
  }

  // Fetch Admin Stats from API
  Future<Map<String, dynamic>> fetchAdminStats() async {
    try {
      final response = await apiClient.get('/admin/stats');
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load stats');
      }
    } catch (e) {
      throw Exception('Error fetching admin stats: $e');
    }
  }

  // Generate a report of students with low attendance
  List<Student> generateLowAttendanceReport() {
    List<Student> lowAttendanceStudents = [];
    for (var student in studentBox.values) {
      if (student.attendanceRate < 50) {
        lowAttendanceStudents.add(student);
      }
    }
    return lowAttendanceStudents;
  }
}
