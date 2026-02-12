import 'package:nlu_portal_app/models/timetable_semester_model.dart';

class TimetableResponse {
  final List<TimetableSemester> timetableList;

  TimetableResponse({required this.timetableList});

  factory TimetableResponse.fromJson(Map<String, dynamic> json) {
    final list = json['ds_tuan_tkb'] as List<dynamic>? ?? [];

    return TimetableResponse(
      timetableList: list
          .map((e) => TimetableSemester.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
