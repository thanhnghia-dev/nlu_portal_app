import 'package:nlu_portal_app/models/timetable_model.dart';

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
