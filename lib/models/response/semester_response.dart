import 'package:nlu_portal_app/models/semester_model.dart';

class SemesterResponse {
  final List<Semester> semesterList;

  SemesterResponse({
    required this.semesterList,
  });

  factory SemesterResponse.fromJson(Map<String, dynamic> json) {
    final list = json['ds_hoc_ky'] as List? ?? [];

    return SemesterResponse(
      semesterList: list
          .map((e) => Semester.fromJson(e))
          .toList(),
    );
  }
}