import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nlu_portal_app/core/utils/constant.dart';
import 'package:nlu_portal_app/models/response/api_response.dart';
import 'package:nlu_portal_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  final baseUrl = Constant.api;

  // Get User Info
  Future<User> fetchUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");

    if (token == null) throw Exception("No token found");

    final response = await http.post(
      Uri.parse('$baseUrl/dkmh/w-locsinhvieninfo'),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({}),
    );

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);

      final apiResponse = ApiResponse<User>.fromJson(
        jsonBody,
        (data) => User.fromJson(data),
      );

      return apiResponse.data;
    } else {
      throw Exception('Failed to load User');
    }
  }
}
