import 'package:flutter/material.dart';
import 'package:school_police/widgets/notification_card.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Get the theme from context

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: theme.iconTheme.color, // Use icon color from theme
            ),
            onPressed: () {
              Navigator.pop(context); // Handle back button press
            },
          ),
          bottom: TabBar(
            indicatorColor:
                theme.colorScheme.primary, // Indicator color from theme
            labelColor:
                theme.colorScheme.primary, // Label color for selected tab
            unselectedLabelColor:
                theme.colorScheme.primary, // Unselected tab color from theme
            tabs: const [
              Tab(text: 'Баталгаажсан хүсэлт'),
              Tab(text: 'Ирсэн хүсэлт'),
            ],
          ),
          backgroundColor: theme
              .appBarTheme.backgroundColor, // App bar background from theme
        ),
        body: TabBarView(
          children: [
            // "Баталгаажсан хүсэлт" Tab
            ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 10, // Sample count
              itemBuilder: (context, index) {
                return const NotificationCard(
                  title: 'Баталгаажсан',
                  message:
                      '246 - р сургуулийн school police хүсэлт баталгаажсан байна.',
                  time: '9:41 AM',
                  imageUrl:
                      'https://via.placeholder.com/150', // Placeholder image URL
                );
              },
            ),

            // "Ирсэн хүсэлт" Tab
            Center(
              child: Text(
                'No incoming requests.',
                style:
                    theme.textTheme.headlineMedium, // Caption color from theme
              ),
            ),
          ],
        ),
      ),
    );
  }
}
