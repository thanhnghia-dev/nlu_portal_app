import 'package:flutter/material.dart';
import 'package:nlu_portal_app/models/notification_model.dart';
import 'package:nlu_portal_app/services/notification_service.dart';

class NotificationProvider with ChangeNotifier {
  List<NotificationAdmin> _notifications = [];
  bool _isLoading = false;

  List<NotificationAdmin> get notifications => _notifications;
  bool get isLoading => _isLoading;

  Future<void> loadNotifications() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await NotificationService().fetchNotification();

      _notifications = response.notificationList;
    } catch (e) {
      _notifications = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}
