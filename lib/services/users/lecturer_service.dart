import 'package:hive/hive.dart';
import 'models/lecturer.dart';
import 'models/student.dart';

class LecturerService {
  final Box<Lecturer> lecturerBox;
  final Box<Student> studentBox;

  LecturerService(this.lecturerBox, this.studentBox);

  // CRUD Operations
  Future<void> createLecturer(Lecturer lecturer) async {
    await lecturerBox.put(lecturer.id, lecturer);
  }

  Lecturer? getLecturer(String id) {
    return lecturerBox.get(id);
  }

  Future<void> updateLecturer(Lecturer lecturer) async {
    await lecturerBox.put(lecturer.id, lecturer);
  }

  Future<void> deleteLecturer(String id) async {
    await lecturerBox.delete(id);
  }

  // Calculate Average Attendance for Lecturer's Course
  double calculateAverageAttendance(String lecturerId) {
    Lecturer? lecturer = lecturerBox.get(lecturerId);
    if (lecturer == null) {
      throw Exception('Lecturer not found');
    }

    // Get all students enrolled in the lecturer's course
    List<Student> students = studentBox.values
        .where((student) => student.enrolledCourses.contains(lecturer.courseId))
        .toList();

    double totalAttendance = 0.0;
    for (var student in students) {
      totalAttendance += student.attendanceRate;
    }

    return totalAttendance / students.length;
  }

  // Fetch lecturers list with caching
  List<Lecturer>? cachedLecturers;

  Future<List<Lecturer>> getLecturers() async {
    if (cachedLecturers != null) {
      return cachedLecturers!;
    }

    cachedLecturers = lecturerBox.values.toList();
    return cachedLecturers!;
  }
}
