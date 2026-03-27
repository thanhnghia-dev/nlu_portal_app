import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nlu_portal_app/core/utils/constant.dart';
import 'package:nlu_portal_app/models/response/api_response.dart';
import 'package:nlu_portal_app/models/response/training_frame_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrainingFrameService {
  final baseUrl = Constant.api;

  // Get Traning Frame list
  Future<TrainingFrameResponse> fetchTrainingFrames() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");

    if (token == null) throw Exception("No token found");

    final requestBody = {
      "filter": {"loai_chuong_trinh_dao_tao": 1},
      "additional": {
        "paging": {"limit": 500, "page": 1},
        "ordering": [
          {"name": null, "order_type": null},
        ],
      },
    };

    final response = await http.post(
      Uri.parse('$baseUrl/sch/w-locdsctdtsinhvien'),
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

      final apiResponse = ApiResponse<TrainingFrameResponse>.fromJson(
        jsonBody,
        (data) => TrainingFrameResponse.fromJson(data),
      );

      return apiResponse.data;
    } else {
      throw Exception("Failed to load Training Frames");
    }
  }
}
