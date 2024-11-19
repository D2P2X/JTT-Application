import 'package:flutter/foundation.dart';
import '../models/game.dart';
import '../services/game_service.dart';

class GameProvider with ChangeNotifier {
  List<Game> _games = [];
  final GameService _gameService = GameService();

  List<Game> get games => _games;

  Future<List<Game>> getAvailableGames() async {
    try {
      _games = await _gameService.getAvailableGames();
      // 디버그
      print(
          'Games after adding: ${_games.map((game) => game.name).join(', ')}');
      notifyListeners();
      return _games;
    } catch (e) {
      print('Error fetching games: $e');
      rethrow;
    }
  }

  // 게임 추가 메서드
  void addGame(Game game) {
    _games.add(game);
    notifyListeners();
  }
}
