import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nlu_portal_app/core/utils/constant.dart';
import 'package:nlu_portal_app/models/response/api_response.dart';
import 'package:nlu_portal_app/models/response/timetable_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimetableService {
  final baseUrl = Constant.api;
  final semester = 20241;

  // Get Timetable list
  Future<TimetableResponse> fetchTimetable() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");

    if (token == null) {
      throw Exception("No token found");
    }

    /// USE FOR SEMESTER
    final requestBody = {
      "hoc_ky": semester,
      "loai_doi_tuong": 1,
      "id_du_lieu": null,
    };

    /// USE FOR WEEK
    /* final requestBody = {
      "filter": {"hoc_ky": 20241, "ten_hoc_ky": ""},
      "additional": {
        "paging": {"limit": 100, "page": 1},
        "ordering": [
          {"name": null, "order_type": null},
        ],
      },
    }; */

    final response = await http.post(
      // Uri.parse('$baseUrl/sch/w-locdstkbtuanusertheohocky'),
      Uri.parse('$baseUrl/sch/w-locdstkbhockytheodoituong'),
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

      final apiResponse = ApiResponse<TimetableResponse>.fromJson(
        jsonBody,
        (data) => TimetableResponse.fromJson(data),
      );

      return apiResponse.data;
    } else {
      throw Exception("Failed to load timetable");
    }
  }
}
