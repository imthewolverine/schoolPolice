import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_police/screens/notification_screen/notification_screen.dart';
import 'package:school_police/screens/profile_screen/profile_screen.dart';
import '../ad_description_screen/ad_description_screen.dart';
import '../add_post_screen/add_post_screen.dart';
import '../home_screen/home_bloc.dart';
import '../home_screen/home_event.dart';
import '../../models/ad.dart';
import '../home_screen/home_state.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc()..add(LoadAds()), // Loading initial ads
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home Screen'),
          actions: [
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationScreen()));
              },
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            _buildSearchSection(),
            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is HomeLoaded) {
                    return _buildAdList(state.ads);
                  } else if (state is HomeError) {
                    return Center(child: Text(state.message));
                  } else {
                    return Center(child: Text('No ads available.'));
                  }
                },
              ),
            ),
          ],
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked, // Center the FAB
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showAddPostBottomSheet(
                context); // Show AddPostScreen as a bottom sheet
          },
          child: Icon(Icons.add),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 8.0,
          child: Container(height: 50.0), // Space for the FAB
        ),
      ),
    );
  }

  void _showAddPostBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled:
          true, // Allows the bottom sheet to be scrollable and controlled
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(20)), // Rounded corners at the top
      ),
      builder: (context) => FractionallySizedBox(
        heightFactor: 0.9, // Take up 90% of the screen height
        child: Column(
          children: [
            // A drag handle at the top
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Expanded(
              child: AddPostScreen(), // Your AddPostScreen contents here
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchSection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search ads...',
          border: OutlineInputBorder(),
          suffixIcon: Icon(Icons.search),
        ),
        onChanged: (query) {
          // Implement search functionality here
        },
      ),
    );
  }

  Widget _buildAdList(List<Ad> ads) {
    return ListView.builder(
      itemCount: ads.length,
      itemBuilder: (context, index) {
        final ad = ads[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AdDescriptionScreen(
                  adId: ad.id,
                  userName: ad.userName,
                  profilePic: ad.profilePic,
                  address: ad.address,
                  details: "Job details here...",
                  price: ad.price,
                  date: ad.date,
                  shift: ad.shift,
                  views: 50,
                  phoneNumber: "1234567890",
                ),
              ),
            );
          },
          child: Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(ad.profilePic),
              ),
              title: Text(ad.userName),
              subtitle: Text('${ad.address}\n${ad.date}'),
              trailing: Text(ad.price),
            ),
          ),
        );
      },
    );
  }
}
