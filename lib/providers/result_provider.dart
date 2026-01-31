import 'package:flutter/material.dart';
import 'package:nlu_portal_app/models/semester_result_model.dart';
import 'package:nlu_portal_app/services/result_service.dart';

class ResultProvider with ChangeNotifier {
  List<SemesterResult> _results = [];
  bool _isLoading = false;

  List<SemesterResult> get results => _results;
  bool get isLoading => _isLoading;

  Future<void> loadResults() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await ResultService().fetchResults();

      _results = response.scoreList;
    } catch (e) {
      _results = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}
