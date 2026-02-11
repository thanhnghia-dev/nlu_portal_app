import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nlu_portal_app/core/utils/constant.dart';
import 'package:nlu_portal_app/models/response/api_response.dart';
import 'package:nlu_portal_app/models/response/result_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultService {
  final baseUrl = Constant.api;

  // Get Result list
  Future<ResultResponse> fetchResults() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");

    if (token == null) throw Exception("No token found");

    final uri = Uri.parse(
      '$baseUrl/srm/w-locdsdiemsinhvien',
    ).replace(queryParameters: {'hien_thi_mon_theo_hkdk': 'false'});

    final response = await http.post(
      uri,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({}),
    );

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      
      if (jsonBody["result"] == false) {
        throw Exception(jsonBody["message"]);
      }

      final apiResponse = ApiResponse<ResultResponse>.fromJson(
        jsonBody,
        (data) => ResultResponse.fromJson(data),
      );

      return apiResponse.data;
    } else {
      throw Exception("Failed to load Results");
    }
  }
}
