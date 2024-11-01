import 'package:flutter/material.dart';
import 'package:school_police/widgets/notification_card.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: theme.iconTheme.color,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          bottom: TabBar(
            indicatorColor: theme.colorScheme.primary,
            labelColor: theme.colorScheme.primary,
            unselectedLabelColor: theme.colorScheme.primary,
            tabs: const [
              Tab(text: 'Баталгаажсан хүсэлт'),
              Tab(text: 'Ирсэн хүсэлт'),
            ],
          ),
          backgroundColor: theme.appBarTheme.backgroundColor,
        ),
        backgroundColor: Colors.white, // Set the Scaffold background to white
        body: TabBarView(
          children: [
            // "Баталгаажсан хүсэлт" Tab
            ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 10, // Sample count
              itemBuilder: (context, index) {
                return const NotificationCard(
                  title: 'Баталгаажсан',
                  message: '246 - р сургуулийн school police хүсэлт баталгаажсан байна.',
                  time: '9:41 AM',
                  imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSxSycPmZ67xN1lxHxyMYOUPxZObOxnkLf6w&s', // Updated image URL
                );
              },
            ),

            // "Ирсэн хүсэлт" Tab
            Center(
              child: Text(
                'No incoming requests.',
                style: theme.textTheme.headlineMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
