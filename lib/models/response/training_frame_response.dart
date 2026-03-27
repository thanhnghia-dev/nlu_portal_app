import 'package:nlu_portal_app/models/training_frame_model.dart';

class TrainingFrameResponse {
  final List<MajorStudent> majorStudentList;
  final List<TrainingSemester> trainingList;

  TrainingFrameResponse({
    required this.majorStudentList,
    required this.trainingList,
  });

  factory TrainingFrameResponse.fromJson(Map<String, dynamic> json) {
    final majorStudentList = json['ds_nganh_sinh_vien'] as List<dynamic>? ?? [];
    final trainingList = json['ds_CTDT_hocky'] as List<dynamic>? ?? [];

    return TrainingFrameResponse(
      majorStudentList: majorStudentList
          .map((e) => MajorStudent.fromJson(e as Map<String, dynamic>))
          .toList(),
      trainingList: trainingList
          .map((e) => TrainingSemester.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
