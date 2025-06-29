import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: dotenv.env['BaseUrl_Auth']!));

  Future<void> login(String email, String password) async {
    final res = await _dio.post(
      '/login',
      data: {"email": email, "password": password},
    );
    if (res.statusCode != 200) throw Exception(res.data['message']);
  }

  Future<void> register(String name, String email, String password) async {
    final res = await _dio.post(
      '/register',
      data: {"name": name, "email": email, "password": password},
    );
    if (res.statusCode != 201) throw Exception(res.data['message']);
  }
}
