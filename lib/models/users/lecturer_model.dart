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

  @HiveField(4)
  final DateTime createdAt; // Timestamp when the lecturer record was created.

  @HiveField(5)
  final DateTime updatedAt; // Timestamp when the lecturer record was last updated.

  Lecturer({
    required this.id,
    required this.name,
    required this.email,
    required this.assignedUnitIds,
    required this.createdAt,
    required this.updatedAt,
  });

  // Serialization
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'assignedUnitIds': assignedUnitIds,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Lecturer.fromMap(Map<String, dynamic> map) {
    return Lecturer(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      assignedUnitIds: List<String>.from(map['assignedUnitIds']),
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}
