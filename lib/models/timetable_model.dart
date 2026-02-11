class Timetable {
  final int startedAt;
  final int periodNumber;
  final int dayOfWeek;
  final String subjectId;
  final String subjectName;
  final String lecturerName;
  final String roomId;

  Timetable({
    required this.startedAt,
    required this.periodNumber,
    required this.dayOfWeek,
    required this.subjectId,
    required this.subjectName,
    required this.lecturerName,
    required this.roomId,
  });

  String get periodRange {
    final end = startedAt + 2;
    return "$startedAt - $end";
  }

  factory Timetable.fromJson(Map<String, dynamic> json) {
    return Timetable(
      startedAt: json['tbd'] ?? 0,
      periodNumber: json['so_tiet'] ?? 0,
      dayOfWeek: json['thu'] ?? 0,
      subjectId: json['ma_mon']?.toString() ?? '',
      subjectName: json['ten_mon']?.toString() ?? '',
      lecturerName: json['gv']?.toString() ?? '',
      roomId: json['phong']?.toString() ?? '',
    );
  }
}
