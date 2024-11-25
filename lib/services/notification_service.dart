import 'dart:convert';
import 'package:http/http.dart' as http;

class NotificationService {
  // Real backend URL for sending notifications
  final String backendUrl = 'https://backend-api-491759785783.asia-northeast1.run.app/send-notification';

  /// Sends a notification using the backend API
  Future<void> sendNotification(String userId, String title, String body) async {
    final url = Uri.parse(backendUrl);

    // Debugging: Print values to ensure correctness
    print("User ID: $userId");
    print("Title: $title");
    print("Body: $body");

    try {
      // Sending the POST request to the backend
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'userId': userId,
          'title': title,
          'body': body,
        }),
      );

      // Handling the response
      if (response.statusCode == 200) {
        print("Notification sent successfully.");
      } else {
        print("Failed to send notification. Status: ${response.statusCode}");
        print("Response Body: ${response.body}");
      }
    } catch (e) {
      print("Error sending notification: $e");
    }
  }
}
