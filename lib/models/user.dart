import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 8)
class UserModel extends HiveObject {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String role;  // e.g., Admin, Lecturer, Student

  @HiveField(3)
  final String email;

  @HiveField(4)
  final String? profilePicture;  // Optional

  @HiveField(5)
  final String passwordHash;  // Added passwordHash field

  @HiveField(6)
  final String username;  // Added username field

  UserModel({
    required this.userId,
    required this.name,
    required this.role,
    required this.email,
    this.profilePicture,
    required this.passwordHash,
    required this.username,  // Added username to the constructor
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'role': role,
      'email': email,
      'profilePicture': profilePicture,
      'passwordHash': passwordHash,
      'username': username,  // Added username to JSON
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      name: json['name'],
      role: json['role'],
      email: json['email'],
      profilePicture: json['profilePicture'],
      passwordHash: json['passwordHash'],
      username: json['username'],  // Added username from JSON
    );
  }
}