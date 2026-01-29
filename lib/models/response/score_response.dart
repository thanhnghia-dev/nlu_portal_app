import 'package:nlu_portal_app/models/semester_score_model.dart';

class ScoreResponse {
  final List<SemesterScore> scoreList;

  ScoreResponse({
    required this.scoreList,
  });

  factory ScoreResponse.fromJson(Map<String, dynamic> json) {
    return ScoreResponse(
      scoreList: json['ds_diem_hocky'],
    );
  }
}