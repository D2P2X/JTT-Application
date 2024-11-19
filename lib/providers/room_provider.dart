import 'package:flutter/foundation.dart';
import '../models/room.dart';
import '../services/room_service.dart';

class RoomProvider with ChangeNotifier {
  final RoomService _roomService = RoomService();

  Stream<List<Room>> getRoomsStream(String gameId) {
    return _roomService.getRoomsStream(gameId);
  }

  void disposeRoomStream(String gameId) {
    _roomService.dispose(gameId);
  }
}
