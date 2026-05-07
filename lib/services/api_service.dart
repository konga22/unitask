import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:unitask/models/auth_data.dart';

class ApiService {
  static final String _hostUrl = 'https://daelim.fleecy.dev/functions/v1';
  static final String _loginUrl = '$_hostUrl/students/login';
  static final String _signupUrl = '$_hostUrl/students/signup';

  static bool _enableOnce = false;

  static Future<bool?> signup({
    required String email,
    required String password,
    required String name,
  }) async {
    if (_enableOnce) return null;
    _enableOnce = true;

    final response = await http.post(
      Uri.parse(_signupUrl),
      body: jsonEncode({'email': email, 'password': password, 'name': name}),
    );
    final statusCode = response.statusCode;

    _enableOnce = false;

    debugPrint('Response[$statusCode]: ${response.body}');

    if (statusCode != 200) {
      debugPrint('에러');
      return false;
    }

    return true;
  }

  static Future<AuthData?> login({
    required String email,
    required String password,
  }) async {
    if (_enableOnce) return null;
    _enableOnce = true;

    final response = await http.post(
      Uri.parse(_loginUrl),
      body: jsonEncode({'email': email, 'password': password}),
    );
    final statusCode = response.statusCode;

    _enableOnce = false;

    if (statusCode != 200) {
      debugPrint('로그인 API 에러: ${response.body}');
      return null;
    }

    debugPrint('로그인 API 성공');

    return AuthData.fromJson(response.body);
  }
}
