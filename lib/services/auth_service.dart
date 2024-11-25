import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:school_police/models/user_model.dart';
import 'package:school_police/services/secure_storage_service.dart';
import 'package:school_police/services/fcm_service.dart';

class AuthService {
  final SecureStorageService _secureStorage = SecureStorageService();
  final FCMService _fcmService = FCMService(); // FCM service for token management
  final String baseUrl =
      'https://backend-api-491759785783.asia-northeast1.run.app/';

  Future<String?> authenticateUser(
      String usernameOrEmail, String password) async {
    try {
      // API call for authentication
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'usernameOrEmail': usernameOrEmail,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        // Extract token and user from the API response
        final token = responseBody['token'];

        // Save token in secure storage
        await _secureStorage.saveToken(token);

        // Handle FCM token after successful login
        await _handleFCMToken();

        return token;
      } else {
        return null; // Authentication failed
      }
    } catch (e) {
      print('Error during authentication: $e');
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
