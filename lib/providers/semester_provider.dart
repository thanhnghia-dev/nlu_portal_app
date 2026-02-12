import 'package:flutter/material.dart';
import 'package:nlu_portal_app/models/semester_model.dart';
import 'package:nlu_portal_app/services/semester_service.dart';

class SemesterProvider with ChangeNotifier {
  List<Semester> _semesters = [];
  bool _isLoading = false;
  int? _selectedSemesterId;

  List<Semester> get semesters => _semesters;
  bool get isLoading => _isLoading;
  int? get selectedSemesterId => _selectedSemesterId;

  Future<void> loadSemesters() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await SemesterService().fetchSemesters();
      _semesters = response.semesterList;

      if (_semesters.isNotEmpty && _selectedSemesterId == null) {
        _selectedSemesterId = _semesters.first.semesterId;
      }
    } catch (e) {
      _semesters = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  void setSelectedSemester(int semesterId) {
    _selectedSemesterId = semesterId;
    notifyListeners();
  }
}
