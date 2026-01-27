import 'package:nlu_portal_app/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  final baseUrl = Constant.api;

  String? _token;
  String? _refreshToken;

  String? get token => _token;
  String? get refreshToken => _refreshToken;

  bool get isAuth => _token != null;

  /// LOGIN
  Future<void> login(String username, String password) async {
    var dio = Dio();

    FormData formData = FormData.fromMap({
      "username": username,
      "password": password,
      "grant_type": "password"
    });

    try {
      var response = await dio.post(
        '$baseUrl/auth/login',
        data: formData,
      );

      debugPrint("Status: ${response.statusCode}");
      debugPrint("Response: ${response.data}");

      if (response.statusCode == 200) {
        final data = response.data;

        _token = data["access_token"];
        _refreshToken = data["refresh_token"];

        if (_token == null) {
          throw Exception("Không tìm thấy access_token trong response: $data");
        }

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", _token!);
        if (_refreshToken != null) {
          await prefs.setString("refresh_token", _refreshToken!);
        }

        notifyListeners();
      } else {
        throw Exception("Login failed: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      debugPrint("Dio error: ${e.response?.data ?? e.message}");
      rethrow;
    } catch (e) {
      debugPrint("Other login error: $e");
      rethrow;
    }
  }

  /// AUTO LOGIN
  Future<void> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("token")) return;

    _token = prefs.getString("token");
    _refreshToken = prefs.getString("refresh_token");

    notifyListeners();
  }

  /// LOGOUT
  Future<void> logout() async {
    if (_token == null) return;

    var dio = Dio();

    try {
      await dio.post(
        '$baseUrl/auth/logout',
        options: Options(headers: {"Authorization": "Bearer $_token"}),
      );
    } catch (e) {
      debugPrint("Logout API error: $e");
    }

    // Remove local token
    _token = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");

    notifyListeners();
  }

}
