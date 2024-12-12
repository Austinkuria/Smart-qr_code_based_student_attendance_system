class Attendance {
  final String studentId;
  final DateTime timestamp;
  final bool isPresent;

  Attendance({
    required this.studentId,
    required this.timestamp,
    required this.isPresent,
  });

  Map<String, dynamic> toJson() {
    return {
      'studentId': studentId,
      'timestamp': timestamp.toIso8601String(),
      'isPresent': isPresent,
    };
  }

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      studentId: json['studentId'],
      timestamp: DateTime.parse(json['timestamp']),
      isPresent: json['isPresent'],
    );
  }
}
