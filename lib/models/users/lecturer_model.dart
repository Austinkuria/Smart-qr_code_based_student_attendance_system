import 'package:hive/hive.dart';

part 'admin_model.g.dart';

@HiveType(typeId: 9)
class Admin {
  @HiveField(0)
  final String id; // Unique admin ID.

  @HiveField(1)
  final String name; // Admin's name.

  @HiveField(2)
  final String email; // Admin's email address.

  @HiveField(3)
  final String password; // Admin's hashed password.

  @HiveField(4)
  final String phoneNumber; // Contact number for admin.

  @HiveField(5)
  final DateTime createdAt; // Timestamp when the admin record was created.

  @HiveField(6)
  final DateTime updatedAt; // Timestamp when the admin record was last updated.

  Admin({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.createdAt,
    required this.updatedAt,
  });

  // Serialization
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Admin.fromMap(Map<String, dynamic> map) {
    return Admin(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      phoneNumber: map['phoneNumber'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}
