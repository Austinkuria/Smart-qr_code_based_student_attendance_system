import 'package:hive/hive.dart';

part 'program_model.g.dart';

@HiveType(typeId: 2)
class Program {
  @HiveField(0)
  final String id; // Unique program ID.

  @HiveField(1)
  final String name; // Program name (e.g., Software Engineering).

  @HiveField(2)
  final String programCode; // Short code for the program (e.g., SE).

  @HiveField(3)
  final List<String> unitIds; // List of unit IDs associated with the program.

  Program({
    required this.id,
    required this.name,
    required this.programCode,
    required this.unitIds,
  });

  // Serialization
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'programCode': programCode,
      'unitIds': unitIds,
    };
  }

  factory Program.fromMap(Map<String, dynamic> map) {
    return Program(
      id: map['id'],
      name: map['name'],
      programCode: map['programCode'],
      unitIds: List<String>.from(map['unitIds']),
    );
  }
}
