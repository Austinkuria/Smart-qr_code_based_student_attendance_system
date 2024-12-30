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

  Admin({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
  });

  // Serialization
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
    };
  }

  factory Admin.fromMap(Map<String, dynamic> map) {
    return Admin(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      phoneNumber: map['phoneNumber'],
    );
  }
}
