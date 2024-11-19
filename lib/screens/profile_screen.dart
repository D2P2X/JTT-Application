import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('프로필'),
      ),
      body: user == null
          ? Center(child: Text('로그인이 필요합니다.'))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
  radius: 50,
  backgroundImage: NetworkImage(
    user.avatarUrl.isNotEmpty 
        ? user.avatarUrl 
        : 'https://via.placeholder.com/150?text=User'
  ),
  onBackgroundImageError: (exception, stackTrace) {
    print('Error loading avatar: $exception');
  },
  child: user.avatarUrl.isEmpty 
      ? Icon(Icons.person, size: 50) 
      : null,
),
                  SizedBox(height: 16),
                  Text(
                    user.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('랭킹: ${user.rank}'),
                  SizedBox(height: 24),
                  ElevatedButton(
                    child: Text('로그아웃'),
                    onPressed: () {
                      userProvider.logout();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
    );
  }
}