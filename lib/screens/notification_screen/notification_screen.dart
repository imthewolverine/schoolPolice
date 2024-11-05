import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../time_record_screen/time_record_screen.dart';
import 'notification_bloc.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: BlocProvider(
        create: (context) => NotificationBloc()..add(LoadNotifications()),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 1,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'Шинэ',
              style: TextStyle(color: Colors.black),
            ),
            bottom: TabBar(
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              tabs: const [
                Tab(text: 'Баталгаажсан хүсэлт'),
                Tab(text: 'Ирсэн хүсэлт'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              // Tab 1: List of verified requests
              BlocBuilder<NotificationBloc, NotificationState>(
                builder: (context, state) {
                  if (state is NotificationInitial) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is NotificationLoaded) {
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      itemCount: state.notifications.length,
                      itemBuilder: (context, index) {
                        final notification = state.notifications[index];
                        return Material(
                          color: Colors.transparent, // Ensures the Material only affects the InkWell
                          borderRadius: BorderRadius.circular(12), // Matches container radius
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12), // Matches container radius
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TimeRecordScreen(adId: notification.id),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 24,
                                    backgroundImage: NetworkImage(notification.imageUrl),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          notification.title,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          notification.message,
                                          style: TextStyle(color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    notification.time,
                                    style: TextStyle(color: Colors.black54, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is NotificationError) {
                    return Center(child: Text('Failed to load notifications'));
                  }
                  return SizedBox.shrink();
                },
              ),
              // Tab 2: Incoming requests tab
              Center(
                child: Text(
                  'No incoming requests.',
                  style: TextStyle(color: Colors.black54, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
