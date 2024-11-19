import 'package:flutter/material.dart';
import '../models/room.dart';

class RoomListItem extends StatelessWidget {
  final Room room;

  const RoomListItem({Key? key, required this.room}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(room.name),
      subtitle: Text('${room.participants}/${room.maxParticipants} 참가자'),
      trailing: ElevatedButton(
        child: Text('참가'),
        onPressed: () {
          // TODO: Implement room joining logic
          print('Joining room: ${room.name}');
          // Navigate to the game room
          // Navigator.pushNamed(context, '/game_room', arguments: room);
        },
      ),
    );
  }
}