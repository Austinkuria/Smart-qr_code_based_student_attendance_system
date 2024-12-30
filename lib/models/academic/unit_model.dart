import 'package:hive/hive.dart';

part 'unit_model.g.dart';

@HiveType(typeId: 3)
class Unit {
  @HiveField(0)
  final String id; // Unique unit ID.

  @HiveField(1)
  final String name; // Unit name (e.g., Data Structures).

  @HiveField(2)
  final String unitCode; // Short code for the unit (e.g., DS101).

  @HiveField(3)
  final String programId; // Program ID this unit belongs to.

  @HiveField(4)
  final int semester; // Semester number (e.g., 1 or 2).

  Unit({
    required this.id,
    required this.name,
    required this.unitCode,
    required this.programId,
    required this.semester,
  });
}
