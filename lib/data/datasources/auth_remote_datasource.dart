import 'dart:convert';
import 'dart:math';

import 'package:absensi_app/core/constants/variables.dart';
import 'package:absensi_app/data/datasources/auth_local_datasource.dart';
import 'package:absensi_app/data/models/response/auth_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDatasource {
  // Login
  Future<Either<String, AuthResponseModel>> login(
      String email, String password) async {
    final url = Uri.parse('${Variable.baseUrl}/api/login');
    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: jsonEncode(
        {'email': email, 'password': password},
      ),
    );

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to login');
    }
  }

  // Logout
  Future<Either<String, String>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final uri = Uri.parse('${Variable.baseUrl}/api/logout');
    final response = await http.post(uri, headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData.token}'
    });
    return response.statusCode == 200
        ? const Right('Successfully logged out')
        : const Left('Failed to logout');
  }
}
