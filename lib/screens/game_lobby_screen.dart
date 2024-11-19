import 'package:flutter/material.dart';
import '../models/game.dart';
import '../models/room.dart';
import '../widgets/room_list_item.dart';
import '../providers/room_provider.dart';
import 'package:provider/provider.dart';

class GameLobbyScreen extends StatefulWidget {
  @override
  _GameLobbyScreenState createState() => _GameLobbyScreenState();
}

class _GameLobbyScreenState extends State<GameLobbyScreen> {
  @override
  Widget build(BuildContext context) {
    final Game game = ModalRoute.of(context)!.settings.arguments as Game;
    final roomProvider = Provider.of<RoomProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(game.name),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              game.description,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Room>>(
              stream: roomProvider.getRoomsStream(game.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('오류가 발생했습니다.'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('현재 열린 방이 없습니다.'));
                }

                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return RoomListItem(room: snapshot.data![index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showCreateRoomDialog(context, game);
        },
      ),
    );
  }

  @override
  void dispose() {
    final Game game = ModalRoute.of(context)!.settings.arguments as Game;
    Provider.of<RoomProvider>(context, listen: false)
        .disposeRoomStream(game.id);
    super.dispose();
  }

  void _showCreateRoomDialog(BuildContext context, Game game) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String roomName = '';
        return AlertDialog(
          title: Text('방 만들기'),
          content: TextField(
            decoration: InputDecoration(hintText: "방 이름을 입력하세요"),
            onChanged: (value) {
              roomName = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('만들기'),
              onPressed: () {
                print('Created room: $roomName for game: ${game.name}');
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
