import 'package:nlu_portal_app/models/semester_result_model.dart';

class ResultResponse {
  final List<SemesterResult> scoreList;

  ResultResponse({required this.scoreList});

  factory ResultResponse.fromJson(Map<String, dynamic> json) {
    final list = json['ds_diem_hocky'] as List<dynamic>;

    return ResultResponse(
      scoreList: list.map((e) => SemesterResult.fromJson(e)).toList(),
    );
  }
}
