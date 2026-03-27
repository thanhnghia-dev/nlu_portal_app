class TimetableSemester {
  final int semesterWeek;
  final String startDate;
  final String endDate;
  final List<Timetable> timetableList;

  TimetableSemester({
    required this.semesterWeek,
    required this.startDate,
    required this.endDate,
    required this.timetableList,
  });

  factory TimetableSemester.fromJson(Map<String, dynamic> json) {
    return TimetableSemester(
      semesterWeek: json['tuan_hoc_ky'],
      startDate: json['ngay_bat_dau'],
      endDate: json['ngay_ket_thuc'],
      timetableList: (json['ds_thoi_khoa_bieu'] as List<dynamic>? ?? [])
          .map((e) => Timetable.fromJson(e))
          .toList(),
    );
  }
}

class Timetable {
  final int startedAt;
  final int periodNumber;
  final int dayOfWeek;
  final String subjectId;
  final String subjectName;
  final String lecturerName;
  final String roomId;
  final DateTime studyDate;

  Timetable({
    required this.startedAt,
    required this.periodNumber,
    required this.dayOfWeek,
    required this.subjectId,
    required this.subjectName,
    required this.lecturerName,
    required this.roomId,
    required this.studyDate,
  });

  String get periodRange {
    final end = startedAt + 2;
    return "$startedAt-$end";
  }

  factory Timetable.fromJson(Map<String, dynamic> json) {
    return Timetable(
      startedAt: json['tiet_bat_dau'] ?? 0,
      periodNumber: json['so_tiet'] ?? 0,
      dayOfWeek: json['thu_kieu_so'] ?? 0,
      subjectId: json['ma_mon']?.toString() ?? '',
      subjectName: json['ten_mon']?.toString() ?? '',
      lecturerName: json['ten_giang_vien']?.toString() ?? '',
      roomId: json['ma_phong']?.toString() ?? '',
      studyDate: DateTime.parse(json['ngay_hoc']),
    );
  }
}
