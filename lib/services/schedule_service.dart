import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nlu_portal_app/core/utils/constant.dart';
import 'package:nlu_portal_app/models/response/api_response.dart';
import 'package:nlu_portal_app/models/response/exam_schedule_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScheduleService {
  final baseUrl = Constant.api;

  // Get Timetable list
  Future<ExamScheduleResponse> fetchSchedules(int semesterId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");

    if (token == null) {
      throw Exception("No token found");
    }

    final requestBody = {
      "filter": {"hoc_ky": semesterId, "is_giua_ky": false},
      "additional": {
        "paging": {"limit": 100, "page": 1},
        "ordering": [
          {"name": null, "order_type": null},
        ],
      },
    };

    final response = await http.post(
      Uri.parse('$baseUrl/epm/w-locdslichthisvtheohocky'),
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

      final apiResponse = ApiResponse<ExamScheduleResponse>.fromJson(
        jsonBody,
        (data) => ExamScheduleResponse.fromJson(data),
      );

      return apiResponse.data;
    } else {
      throw Exception("Failed to load timetable");
    }
  }
}