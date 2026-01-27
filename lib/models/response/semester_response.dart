import 'package:nlu_portal_app/models/semester_model.dart';

class SemesterResponse {
  final int currentSemester;
  final List<Semester> semesterList;

  SemesterResponse({
    required this.currentSemester,
    required this.semesterList,
  });

  factory SemesterResponse.fromJson(Map<String, dynamic> json) {
    return SemesterResponse(
      currentSemester: json['hoc_ky_theo_ngay_hien_tai'],
      semesterList: json['ds_hoc_ky'],
    );
  }
}