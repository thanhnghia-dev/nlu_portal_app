import 'package:nlu_portal_app/models/semester_model.dart';

class SemesterResponse {
  final int currentSemester;
  final int totalItems;
  final List<Semester> semesterList;

  SemesterResponse({
    required this.currentSemester,
    required this.totalItems,
    required this.semesterList,
  });

  factory SemesterResponse.fromJson(Map<String, dynamic> json) {
    return SemesterResponse(
      currentSemester: json['hoc_ky_theo_ngay_hien_tai'],
      totalItems: json['total_items'],
      semesterList: (json['ds_hoc_ky'] as List)
        .map((e) => Semester.fromJson(e))
        .toList(),
    );
  }
}