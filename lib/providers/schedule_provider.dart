import 'package:flutter/material.dart';
import 'package:nlu_portal_app/models/exam_schedule_model.dart';
import 'package:nlu_portal_app/services/schedule_service.dart';

class ScheduleProvider with ChangeNotifier {
  List<ExamSchedule> _schedules = [];
  int? _selectedSemesterId;
  bool _isLoading = false;

  List<ExamSchedule> get schedules => _schedules;
  int? get selectedSemesterId => _selectedSemesterId;
  bool get isLoading => _isLoading;

  void setSemester(int semesterId) {
    _selectedSemesterId = semesterId;
    loadSchedules();
  }

  Future<void> loadSchedules() async {
    if (_selectedSemesterId == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      final response = await ScheduleService().fetchSchedules(_selectedSemesterId!);

      _schedules = response.scheduleList;
    } catch (e) {
      _schedules = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}