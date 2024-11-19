import '../models/room.dart';
import 'dart:async';

class RoomService {
  // 각 게임 ID별로 스트림 컨트롤러를 저장
  final Map<String, StreamController<List<Room>>> _controllers = {};

  Stream<List<Room>> getRoomsStream(String gameId) {
    if (!_controllers.containsKey(gameId)) {
      _controllers[gameId] = StreamController<List<Room>>.broadcast();
      _startFetching(gameId);
    }
    return _controllers[gameId]!.stream;
  }

  void _startFetching(String gameId) async {
    while (true) {
      try {
        // 실제 서버에서는 WebSocket을 사용하겠지만, 여기서는 더미 데이터로 시뮬레이션
        await Future.delayed(Duration(seconds: 1));
        final rooms = [
          Room(id: '1', name: '즐거운 게임방', participants: 3, maxParticipants: 8),
          Room(id: '2', name: '초보만', participants: 2, maxParticipants: 4),
          Room(id: '3', name: '고수만', participants: 5, maxParticipants: 6),
        ];

        if (!_controllers[gameId]!.isClosed) {
          _controllers[gameId]!.add(rooms);
        }
      } catch (e) {
        print('Error fetching rooms: $e');
      }
    }
  }

  void dispose(String gameId) {
    _controllers[gameId]?.close();
    _controllers.remove(gameId);
  }
}
