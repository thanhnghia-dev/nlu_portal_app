import 'package:flutter/material.dart';
import 'package:nlu_portal_app/models/timetable_model.dart';
import 'package:nlu_portal_app/services/timetable_service.dart';

class TimetableProvider with ChangeNotifier {
  List<Timetable> _timetables = [];
  bool _isLoading = false;

  List<Timetable> get timetables => _timetables;
  bool get isLoading => _isLoading;

  Future<void> loadTimetable() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await TimetableService().fetchTimetable();

      _timetables = response.timetableList;
    } catch (e) {
      _timetables = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}
