import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:unitask/app/app_strings.dart';
import 'package:unitask/core/extensions/models/result.dart';
import 'package:unitask/models/auth_data.dart';

class AuthApiService {
  final String _loginUrl = '${AppStrings.apiHostUrl}/students/login';
  final String _signupUrl = '${AppStrings.apiHostUrl}/students/signup';

  Future<Result<void>> signup({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(_signupUrl),
        body: jsonEncode({'email': email, 'password': password, 'name': name}),
      );
      final statusCode = response.statusCode;
      debugPrint('Response[$statusCode]: ${response.body}');

      if (statusCode != 200) {
        debugPrint('에러');
        return Failure(Exception('계정 생성을 실패했습니다.'));
      }

      return const Success(null);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Future<Result<AuthData?>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(_loginUrl),
        body: jsonEncode({'email': email, 'password': password}),
      );
      final statusCode = response.statusCode;

      if (statusCode != 200) {
        debugPrint('로그인 API 에러: ${response.body}');
        throw Failure(Exception('로그인을 실패했습니다'));
      }

      debugPrint('로그인 API 성공');
      final authData = AuthData.fromJson(response.body);
      return Success(authData);
    } on Exception catch (e) {
      return Failure(e);
    }
  }
}
