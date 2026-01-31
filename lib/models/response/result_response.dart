import 'package:nlu_portal_app/models/semester_result_model.dart';

class ResultResponse {
  final List<SemesterResult> scoreList;

  ResultResponse({required this.scoreList});

  factory ResultResponse.fromJson(Map<String, dynamic> json) {
    return ResultResponse(scoreList: json['ds_diem_hocky']);
  }
}
