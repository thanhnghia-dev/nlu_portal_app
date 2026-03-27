import 'package:flutter/material.dart';
import 'package:nlu_portal_app/models/training_frame_model.dart';
import 'package:nlu_portal_app/services/training_frame_service.dart';

class TrainingFrameProvider with ChangeNotifier {
  List<MajorStudent> _majors = [];
  List<TrainingSemester> _frames = [];
  bool _isLoading = false;

  List<MajorStudent> get majors => _majors;
  List<TrainingSemester> get frames => _frames;
  bool get isLoading => _isLoading;

  Future<void> loadTrainingFrames() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await TrainingFrameService().fetchTrainingFrames();

      _majors = response.majorStudentList;
      _frames = response.trainingList;
    } catch (e) {
      _majors = [];
      _frames = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}
