import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../providers/game_provider.dart';
import '../widgets/game_card.dart';
import '../models/game.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Game>> _gamesFuture;

  @override
  void initState() {
    super.initState();
    _gamesFuture =
        Provider.of<GameProvider>(context, listen: false).getAvailableGames();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final gameProvider = Provider.of<GameProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('JTT'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildUserInfo(userProvider),
          _buildGameList(gameProvider),
        ],
      ),
      floatingActionButton: userProvider.currentUser == null
          ? FloatingActionButton(
              child: Icon(Icons.login),
              onPressed: () async {
                try {
                  await userProvider.login('testuser', 'password');
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('로그인 실패: $e')),
                  );
                }
              },
            )
          : null,
    );
  }

  Widget _buildUserInfo(UserProvider userProvider) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey[300],
            child: userProvider.currentUser == null
                ? Icon(Icons.person, size: 30, color: Colors.grey[600])
                : userProvider.currentUser!.avatarUrl.isNotEmpty
                    ? ClipOval(
                        child: Image.network(
                          userProvider.currentUser!.avatarUrl,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.person,
                                size: 30, color: Colors.grey[600]);
                          },
                        ),
                      )
                    : Icon(Icons.person, size: 30, color: Colors.grey[600]),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userProvider.currentUser?.name ?? '게스트',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text('랭킹: ${userProvider.currentUser?.rank ?? 'N/A'}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGameList(GameProvider gameProvider) {
    return Expanded(
      child: FutureBuilder<List<Game>>(
        future: _gamesFuture,
        builder: (context, snapshot) {
          print('Connection state: ${snapshot.connectionState}'); // 디버그용
          print('Data: ${snapshot.data}'); // 디버그용
          print('Error: ${snapshot.error}'); // 디버그용

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('오류가 발생했습니다.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('사용 가능한 게임이 없습니다.'));
          }

          return GridView.builder(
            padding: EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return GameCard(game: snapshot.data![index]);
            },
          );
        },
      ),
    );
  }

  void _showCreateRoomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('방 만들기'),
          content: TextField(
            decoration: InputDecoration(hintText: "방 이름을 입력하세요"),
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
                // TODO: Implement room creation logic
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/game_lobby');
              },
            ),
          ],
        );
      },
    );
  }
}
