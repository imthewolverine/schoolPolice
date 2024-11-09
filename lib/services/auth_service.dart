import 'package:school_police/models/user_model.dart';
import 'package:school_police/services/secure_storage_service.dart';

class AuthService {
  final SecureStorageService _secureStorage = SecureStorageService();

  final List<User> _users = [
    User(
      username: 'admin',
      firstName: 'batla',
      lastName: 'lhagva',
      password: '123',
      email: 'batlhagva15@gmail.com',
      phoneNumber: 80553609,
      role: UserRole.schoolPolice,
      assignedSchools: ['5-р сургууль'],
    ),
    User(
      username: 'not admin',
      firstName: 'lhagva',
      lastName: 'batla',
      password: '321',
      email: 'batlhagva15@gmail.com',
      phoneNumber: 9055360,
      role: UserRole.parent,
      assignedSchools: ['5-р сургууль'],
    ),
  ];

  Future<String?> authenticateUser(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    try {
      final user = _users.firstWhere(
            (user) => user.username == username && user.password == password,
      );
      final token = 'dummy_token_for_${user.username}';
      await _secureStorage.saveToken(token);
      await _secureStorage.saveUser(user);
      return token;
    } catch (e) {
      return null;
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _secureStorage.getToken();
    return token != null;
  }

  Future<User?> getUser() async {
    return await _secureStorage.getUser();
  }

  Future<void> logout() async {
    await _secureStorage.deleteToken();
    await _secureStorage.deleteUser();
  }
}
