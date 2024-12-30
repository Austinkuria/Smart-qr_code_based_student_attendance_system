import 'package:hive/hive.dart';

part 'lecturer_model.g.dart';

@HiveType(typeId: 1)
class Lecturer {
  @HiveField(0)
  final String id; // Unique identifier for the lecturer.

  @HiveField(1)
  final String name; // Full name of the lecturer.

  @HiveField(2)
  final String email; // Email address for lecturer communication.

  @HiveField(3)
  final List<String> assignedUnitIds; // List of unit IDs the lecturer is assigned to.

  Lecturer({
    required this.id,
    required this.name,
    required this.email,
    required this.assignedUnitIds,
  });
}
