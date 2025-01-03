import 'package:hive/hive.dart';
import 'models/student.dart';

class StudentService {
  final Box<Student> studentBox;

  StudentService(this.studentBox);

  // CRUD Operations
  Future<void> createStudent(Student student) async {
    await studentBox.put(student.id, student);
  }

  Student? getStudent(String id) {
    return studentBox.get(id);
  }

  Future<void> updateStudent(Student student) async {
    await studentBox.put(student.id, student);
  }

  Future<void> deleteStudent(String id) async {
    await studentBox.delete(id);
  }

  // Validate if a student can enroll in a course
  bool canEnrollInCourse(String studentId, String courseId) {
    Student? student = studentBox.get(studentId);
    if (student == null) {
      throw Exception('Student not found');
    }

    int maxCourses = 5;
    if (student.enrolledCourses.length >= maxCourses) {
      return false; // Student can't enroll in more courses
    }

    return true; // Student can enroll in the course
  }

  // Generate a list of students with low attendance
  List<Student> generateLowAttendanceReport() {
    List<Student> lowAttendanceStudents = [];
    for (var student in studentBox.values) {
      if (student.attendanceRate < 50) {
        lowAttendanceStudents.add(student);
      }
    }
    return lowAttendanceStudents;
  }

  // Method to get the list of students enrolled in a specific course
  List<Student> getStudentsEnrolledInCourse(String courseId) {
    List<Student> studentsInCourse = [];
    for (var student in studentBox.values) {
      if (student.enrolledCourses.contains(courseId)) {
        studentsInCourse.add(student);
      }
    }
    return studentsInCourse;
  }
}
