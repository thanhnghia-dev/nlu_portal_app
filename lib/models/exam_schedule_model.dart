class ExamSchedule {
  final String subjectId;
  final String subjectName;
  final String roomId;
  final String examDate;
  final String startedAt;

  ExamSchedule({
    required this.subjectId,
    required this.subjectName,
    required this.roomId,
    required this.examDate,
    required this.startedAt,
  });

  factory ExamSchedule.fromJson(Map<String, dynamic> json) {
    return ExamSchedule(
      subjectId: json['ma_mon'],
      subjectName: json['ten_mon'],
      roomId: json['ma_phong'],
      examDate: json['ngay_thi'],
      startedAt: json['tiet_bat_dau'],
    );
  }
}
