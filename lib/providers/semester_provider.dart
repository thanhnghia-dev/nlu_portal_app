import 'package:flutter/material.dart';
import 'package:nlu_portal_app/models/semester_model.dart';
import 'package:nlu_portal_app/services/semester_service.dart';

class SemesterProvider with ChangeNotifier {
  List<Semester> _semesters = [];
  int? _currentSemester;
  bool _isLoading = false;

  List<Semester> get semesters => _semesters;
  int? get currentSemester => _currentSemester;
  bool get isLoading => _isLoading;

  Future<void> loadSemesters() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await SemesterService().fetchSemesters();

      _semesters = response.semesterList;
      _currentSemester = response.currentSemester;
    } catch (e) {
      _semesters = [];
      _currentSemester = null;
    }

    _isLoading = false;
    notifyListeners();
  }
}
