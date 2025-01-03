import 'package:hive/hive.dart';

part 'student_model.g.dart';

@HiveType(typeId: 0)
class Student {
  @HiveField(0)
  final String registrationNumber; // Unique identifier for the student.

  @HiveField(1)
  final String name; // Full name of the student.

  @HiveField(2)
  final String password; // Hashed password for authentication.

  @HiveField(3)
  final int year; // Year of study (e.g., 1, 2, 3, 4).

  @HiveField(4)
  final String programId; // ID linking to the program the student is enrolled in.

  @HiveField(5)
  final List<String> enrolledUnitIds; // List of unit IDs the student is taking.

  @HiveField(6)
  final DateTime createdAt; // Timestamp when the student record was created.

  @HiveField(7)
  final DateTime updatedAt; // Timestamp when the student record was last updated.

  Student({
    required this.registrationNumber,
    required this.name,
    required this.password,
    required this.year,
    required this.programId,
    required this.enrolledUnitIds,
    required this.createdAt,
    required this.updatedAt,
  });

  // Serialization
  Map<String, dynamic> toMap() {
    return {
      'registrationNumber': registrationNumber,
      'name': name,
      'password': password,
      'year': year,
      'programId': programId,
      'enrolledUnitIds': enrolledUnitIds,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      registrationNumber: map['registrationNumber'],
      name: map['name'],
      password: map['password'],
      year: map['year'],
      programId: map['programId'],
      enrolledUnitIds: List<String>.from(map['enrolledUnitIds']),
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}
