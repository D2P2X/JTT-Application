import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class AuthService {
  Future<User> login(String username, String password) async {
    // 실제 로그인 로직 대신 더미 데이터 반환
    await Future.delayed(Duration(seconds: 1)); // 네트워크 지연 시뮬레이션
    return User(
      id: '1',
      name: '테스트 사용자',
      avatarUrl: 'https://via.placeholder.com/150',
      rank: 100,
    );
  }
}
// class AuthService {
//   final String baseUrl = 'https://api.tenten.com'; // 가상의 API 주소

//   Future<User> login(String username, String password) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/login'),
//       body: jsonEncode({'username': username, 'password': password}),
//       headers: {'Content-Type': 'application/json'},
//     );

//     if (response.statusCode == 200) {
//       return User.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception('Failed to login');
//     }
//   }
// }