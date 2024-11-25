import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:school_police/models/user_model.dart';
import 'package:school_police/services/secure_storage_service.dart';
import 'package:school_police/services/fcm_service.dart';

class AuthService {
  final SecureStorageService _secureStorage = SecureStorageService();
  final FCMService _fcmService = FCMService(); // FCM service for token management

  final List<User> _users = [
    User(
      userId: '1',
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
      userId: '2',
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
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

    try {
      // Find user in the list
      final user = _users.firstWhere(
            (user) => user.username == username && user.password == password,
      );

      // Generate a dummy token for the user
      final token = 'dummy_token_for_${user.username}';

      // Save the token and user details in secure storage
      await _secureStorage.saveToken(token);
      await _secureStorage.saveUser(user);

      // Handle FCM token after successful login
      await _handleFCMToken();

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

  Future<void> _handleFCMToken() async {
    try {
      // Retrieve FCM Token
      String? fcmToken = await FirebaseMessaging.instance.getToken();

      if (fcmToken != null) {
        print("FCM Token: $fcmToken");

        // Send FCM token to the backend
        await _fcmService.sendTokenToBackend(fcmToken);
      }

      // Listen for FCM token refresh
      FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
        print("FCM Token refreshed: $newToken");

        // Send the refreshed token to the backend
        await _fcmService.sendTokenToBackend(newToken);
      });
    } catch (e) {
      print("Error handling FCM Token: $e");
    }
  }
}
/*import 'package:school_police/models/user_model.dart';
import 'package:school_police/services/secure_storage_service.dart';

class AuthService {
  final SecureStorageService _secureStorage = SecureStorageService();

  final List<User> _users = [
    User(
      userId: '1', // Unique userId for each user
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
      userId: '2', // Unique userId for each user
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
}*/
