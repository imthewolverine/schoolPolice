import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String message;
  final String time;
  final String imageUrl;

  const NotificationCard({
    Key? key,
    required this.title,
    required this.message,
    required this.time,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Get the theme from the context

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: theme.colorScheme.surface, // Use the card color from the theme
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        title: Text(
          title,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 16, // Normal font size for the title
          ),
        ),
        subtitle: Text(
          message,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: 14, // Normal font size for the message
          ),
        ),
        trailing: Text(
          time,
          style: const TextStyle(
            fontSize: 12, // Normal font size for the time
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
