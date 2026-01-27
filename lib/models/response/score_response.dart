import 'package:nlu_portal_app/models/semester_model.dart';

class ScoreResponse {
  final List<Semester> scoreList;

  ScoreResponse({
    required this.scoreList,
  });

  factory ScoreResponse.fromJson(Map<String, dynamic> json) {
    return ScoreResponse(
      scoreList: json['ds_diem_hocky'],
    );
  }
}