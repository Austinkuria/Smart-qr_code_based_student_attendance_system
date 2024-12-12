class Session {
  final String sessionId;
  final DateTime sessionDate;
  final String lecturerId;

  Session({
    required this.sessionId,
    required this.sessionDate,
    required this.lecturerId,
  });

  Map<String, dynamic> toJson() {
    return {
      'sessionId': sessionId,
      'sessionDate': sessionDate.toIso8601String(),
      'lecturerId': lecturerId,
    };
  }

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      sessionId: json['sessionId'],
      sessionDate: DateTime.parse(json['sessionDate']),
      lecturerId: json['lecturerId'],
    );
  }
}
