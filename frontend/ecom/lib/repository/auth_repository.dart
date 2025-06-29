import 'package:dio/dio.dart';

class AuthRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://10.0.2.2:5000/api/auth'));

  Future<void> login(String email, String password) async {
    final res = await _dio.post('/login', data: {"email": email, "password": password});
    if (res.statusCode != 200) throw Exception(res.data['message']);
  }

  Future<void> register(String name, String email, String password) async {
    final res = await _dio.post('/register', data: {"name": name, "email": email, "password": password});
    if (res.statusCode != 201) throw Exception(res.data['message']);
  }
}
