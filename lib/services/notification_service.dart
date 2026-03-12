import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nlu_portal_app/core/utils/constant.dart';
import 'package:nlu_portal_app/models/response/api_response.dart';
import 'package:nlu_portal_app/models/response/notification_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  final baseUrl = Constant.api;

  // Get Timetable list
  Future<NotificationResponse> fetchNotification() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");

    if (token == null) {
      throw Exception("No token found");
    }

    final requestBody = {
      "filter": {"id":null, "is_noi_dung":true, "is_web":true},
      "additional": {
        "paging": {"limit": 50, "page": 1},
        "ordering": [
          {"name": "ngay_gui", "order_type": 1},
        ],
      },
    };

    final response = await http.post(
      Uri.parse('$baseUrl/web/w-locdsthongbao'),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);

      if (jsonBody["result"] == false) {
        throw Exception(jsonBody["message"]);
      }

      final apiResponse = ApiResponse<NotificationResponse>.fromJson(
        jsonBody,
        (data) => NotificationResponse.fromJson(data),
      );

      return apiResponse.data;
    } else {
      throw Exception("Failed to load notification");
    }
  }
}
