import 'package:flutter/material.dart';
import 'package:nlu_portal_app/models/timetable_model.dart';
import 'package:nlu_portal_app/models/timetable_semester_model.dart';
import 'package:nlu_portal_app/services/timetable_service.dart';

class TimetableProvider with ChangeNotifier {
  final TimetableService _service = TimetableService();

  List<TimetableSemester> _semesters = [];
  List<Timetable> _allTimetables = [];
  int? _selectedSemesterId;

  bool _isLoading = false;
  int? get selectedSemesterId => _selectedSemesterId;
  DateTime _selectedDate = DateTime.now();

  bool get isLoading => _isLoading;
  DateTime get selectedDate => _selectedDate;

  void setSemester(int semesterId) {
    _selectedSemesterId = semesterId;
    loadTimetable();
  }

  /// -------------------------
  /// LOAD DATA
  /// -------------------------
  Future<void> loadTimetable() async {
    if (_selectedSemesterId == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      final response = await _service.fetchTimetable(_selectedSemesterId!);

      _semesters = response.timetableList;

      // 🔥 Flatten 1 lần duy nhất
      _allTimetables = _semesters
          .expand((semester) => semester.timetableList)
          .toList();
    } catch (e) {
      _semesters = [];
      _allTimetables = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  /// -------------------------
  /// SET SELECTED DATE
  /// -------------------------
  void setSelectedDate(DateTime date) {
    _selectedDate = DateTime(date.year, date.month, date.day);
    notifyListeners();
  }

  /// -------------------------
  /// LỌC THEO NGÀY ĐƯỢC CHỌN
  /// -------------------------
  List<Timetable> get timetablesBySelectedDate {
    final result = _allTimetables.where((item) {
      final d = item.studyDate;
      return d.year == _selectedDate.year &&
          d.month == _selectedDate.month &&
          d.day == _selectedDate.day;
    }).toList();

    result.sort((a, b) => a.startedAt.compareTo(b.startedAt));

    return result;
  }

  /// -------------------------
  /// DÙNG CHO CALENDAR (chấm màu)
  /// -------------------------
  List<Timetable> getEventsForDay(DateTime day) {
    return _allTimetables.where((item) {
      final d = item.studyDate;
      return d.year == day.year &&
          d.month == day.month &&
          d.day == day.day;
    }).toList();
  }

  /// -------------------------
  /// CHECK NGÀY CÓ MÔN
  /// -------------------------
  bool hasEvent(DateTime day) {
    return getEventsForDay(day).isNotEmpty;
  }
}
