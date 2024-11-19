import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/game.dart';

class GameService {
  Future<List<Game>> getAvailableGames() async {
    // 실제 API 호출 대신 더미 데이터 반환
    print("getAvailableGames start");
    await Future.delayed(Duration(seconds: 1)); // 네트워크 지연 시뮬레이션
    print("getAvailableGames end");
    return [
      Game(
          id: '1',
          name: '퀴즈게임',
          description: '재미있는 퀴즈 게임입니다.',
          imageUrl: 'https://via.placeholder.com/150'),
      Game(
          id: '2',
          name: '그림맞추기',
          description: '그림을 보고 정답을 맞추세요.',
          imageUrl: 'https://via.placeholder.com/150'),
      Game(
          id: '3',
          name: '단어게임',
          description: '주어진 단어로 문장을 만드세요.',
          imageUrl: 'https://via.placeholder.com/150'),
    ];
  }
}

//todo 실제 서버 연동 시 사용
// class GameService {
//   final String baseUrl = 'https://api.tenten.com'; // 가상의 API 주소

//   Future<List<Game>> getAvailableGames() async {
//     final response = await http.get(Uri.parse('$baseUrl/games'));

//     if (response.statusCode == 200) {
//       List<dynamic> gamesJson = jsonDecode(response.body);
//       return gamesJson.map((json) => Game.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to load games');
//     }
//   }
// }
