import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nlu_portal_app/core/utils/constant.dart';
import 'package:nlu_portal_app/models/response/api_response.dart';
import 'package:nlu_portal_app/models/response/semester_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SemesterService {
  final baseUrl = Constant.api;

  // Get Semester list
  Future<SemesterResponse> fetchSemesters() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token");

    if (accessToken == null) throw Exception("No token");

    final response = await http.post(
      Uri.parse('$baseUrl/sch/w-locdshockytkbuser'),
      headers: {
        "Authorization": "Bearer $accessToken",
        "Content-Type": "application/json",
      },
      body: jsonEncode({}),
    );

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      
      final apiResponse = ApiResponse<SemesterResponse>.fromJson(
        jsonBody,
        (data) => SemesterResponse.fromJson(data),
      );

      return apiResponse.data;
    } else {
      throw Exception("Failed to load semesters");
    }
  }
}
