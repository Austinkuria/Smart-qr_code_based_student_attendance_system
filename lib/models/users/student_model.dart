import 'package:hive/hive.dart';

part 'student_model.g.dart';

@HiveType(typeId: 0)
class Student {
  @HiveField(0)
  final String registrationNumber; // Unique identifier for the student.

  @HiveField(1)
  final String name; // Full name of the student.

  @HiveField(2)
  final int year; // Year of study (e.g., 1, 2, 3, 4).

  @HiveField(3)
  final String programId; // ID linking to the program the student is enrolled in.

  @HiveField(4)
  final List<String> enrolledUnitIds; // List of unit IDs the student is taking.

  Student({
    required this.registrationNumber,
    required this.name,
    required this.year,
    required this.programId,
    required this.enrolledUnitIds,
  });
}
