import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class UserProvider with ChangeNotifier {
  User? _currentUser;
  final AuthService _authService = AuthService();
  final String defaultAvatarUrl = 'https://via.placeholder.com/150?text=User';

  User? get currentUser => _currentUser;

  Future<void> login(String username, String password) async {
    try {
      _currentUser = await _authService.login(username, password);
      notifyListeners();
    } catch (e) {
      print('Login error: $e');
      rethrow;
    }
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}
