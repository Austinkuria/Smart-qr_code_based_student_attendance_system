import 'package:hive/hive.dart';

part 'class.g.dart';

@HiveType(typeId: 3)
class Class {
  @HiveField(0)
  final String classId;

  @HiveField(1)
  final String className;

  @HiveField(2)
  final String lecturerId;

  @HiveField(3)
  final DateTime startDate;

  @HiveField(4)
  final DateTime endDate;

  @HiveField(5)
  final String? roomId; // Optional room ID

  @HiveField(6)
  final String? semester; // Optional semester

  Class({
    required this.classId,
    required this.className,
    required this.lecturerId,
    required this.startDate,
    required this.endDate,
    this.roomId,
    this.semester,
  });
}
