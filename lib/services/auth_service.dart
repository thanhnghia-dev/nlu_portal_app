import 'package:nlu_portal_app/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService with ChangeNotifier {
  final baseUrl = Constant.api;

  String? _token;
  String? _refreshToken;

  String? get token => _token;
  String? get refreshToken => _refreshToken;

  bool get isAuth => _token != null;

  /// LOGIN
  Future<void> login(String username, String password) async {
    final dio = Dio();

    try {
      final response = await dio.post(
        '$baseUrl/auth/login',
        data: {
          'username': username,
          'password': password,
          'grant_type': 'password',
        },
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      if (response.statusCode == 200) {
        final data = response.data;

        _token = data['access_token'];
        _refreshToken = data['refresh_token'];

        if (_token == null) {
          throw Exception("Không tìm thấy access_token");
        }

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', _token!);
        if (_refreshToken != null) {
          await prefs.setString('refresh_token', _refreshToken!);
        }

        notifyListeners();
      }
    } on DioException catch (e) {
      debugPrint("Dio error: ${e.response?.data ?? e.message}");
      rethrow;
    }
  }

  /// AUTO LOGIN
  Future<void> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("access_token")) return;

    _token = prefs.getString("access_token");
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
    await prefs.remove("access_token");

    notifyListeners();
  }
}
