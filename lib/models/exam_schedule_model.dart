class ExamSchedule {
  final String subjectId;
  final String subjectName;
  final String roomId;
  final String examDate;
  final int startedAt;
  final int totalPeriods;

  ExamSchedule({
    required this.subjectId,
    required this.subjectName,
    required this.roomId,
    required this.examDate,
    required this.startedAt,
    required this.totalPeriods,
  });

  String get periodRange {
    final end = startedAt + totalPeriods - 1;
    return "$startedAt-$end";
  }

  factory ExamSchedule.fromJson(Map<String, dynamic> json) {
    return ExamSchedule(
      subjectId: json['ma_mon']?.toString() ?? '',
      subjectName: json['ten_mon']?.toString() ?? '',
      roomId: json['ma_phong']?.toString() ?? '',
      examDate: json['ngay_thi']?.toString() ?? '',
      startedAt: int.parse(json['tiet_bat_dau']),
      totalPeriods: int.parse(json['so_tiet']),
    );
  }
}
