import 'package:nlu_portal_app/models/notification_model.dart';

class NotificationResponse {
  final List<NotificationAdmin> notificationList;

  NotificationResponse({required this.notificationList});

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    final list = json['ds_thong_bao'] as List<dynamic>? ?? [];

    return NotificationResponse(
      notificationList: list
          .map((e) => NotificationAdmin.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
