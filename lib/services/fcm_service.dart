import 'package:http/http.dart' as http;
import 'dart:convert';

class FCMService {
  final String backendUrl;

  // Constructor with the real backend URL
  FCMService() : backendUrl = "https://backend-api-491759785783.asia-northeast1.run.app";

  /// Sends the FCM token and userId to the backend
  Future<void> sendTokenToBackend(String? token) async {
    if (token == null) {
      print("FCM token is null, skipping send to backend.");
      return;
    }

    // Hardcoded userId for testing
    String userId = "1";

    // Construct the full endpoint URL
    final url = Uri.parse("$backendUrl/save-fcm-token");

    try {
      // Sending the POST request
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'token': token,
          'userId': userId,
        }),
      );

      // Handling the response
      if (response.statusCode == 200) {
        print("Token sent to backend successfully.");
      } else {
        print("Failed to send token to backend.");
        print("Status code: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (e) {
      print("Error sending token to backend: $e");
    }
  }
}
