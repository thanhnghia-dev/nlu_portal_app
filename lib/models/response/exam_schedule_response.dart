import 'package:nlu_portal_app/models/exam_schedule_model.dart';

class ExamScheduleResponse {
  final List<ExamSchedule> scheduleList;

  ExamScheduleResponse({required this.scheduleList});

  factory ExamScheduleResponse.fromJson(Map<String, dynamic> json) {
    final list = json['ds_lich_thi'] as List<dynamic>? ?? [];

    return ExamScheduleResponse(
      scheduleList: list
          .map((e) => ExamSchedule.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
