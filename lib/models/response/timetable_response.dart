import 'package:nlu_portal_app/models/timetable_model.dart';

class TimetableResponse {
  final List<Timetable> timetableList;

  TimetableResponse({required this.timetableList});

factory TimetableResponse.fromJson(Map<String, dynamic> json) {
  final list = json['ds_nhom_to'] as List<dynamic>? ?? [];

  return TimetableResponse(
    timetableList: list
        .map((e) => Timetable.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

}
