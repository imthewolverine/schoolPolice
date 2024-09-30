import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                // Navigate to notifications
              },
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                // Navigate to profile screen
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
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // Navigate to AddPostScreen and await the new ad
            final newAd = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddPostScreen()),
            );

            // Check if the returned value is an Ad object
            if (newAd != null && newAd is Ad) {
              // Add the new ad to the HomeBloc
              context.read<HomeBloc>().add(AddNewAd(newAd));
              // The BlocBuilder will automatically update the UI
            }
          },
          child: Icon(Icons.add),
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
          // Handle search query
          // You might want to implement a search feature here
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
                  details: "Job details here...", // Placeholder for actual details
                  price: ad.price,
                  date: ad.date,
                  shift: ad.shift, // Ensure you're passing actual shift
                  views: 50, // Placeholder value
                  phoneNumber: "1234567890", // Placeholder value
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






/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../ad_description_screen/ad_description_screen.dart';
import '../add_post_screen/add_post_screen.dart';
import 'home_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';
import '../../models/ad.dart';

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
                // Navigate to notifications
              },
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                // Navigate to profile screen
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
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final newAd = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddPostScreen()),
            );
            if (newAd != null && newAd is Ad) {
              // Add the new ad to the HomeBloc once it's returned
              context.read<HomeBloc>().add(AddNewAd(newAd));
            }
          },
          child: Icon(Icons.add),
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
          // Handle search query
          // You might want to implement a search feature here
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
                  details: "Job details here...", // Placeholder for actual details
                  price: ad.price,
                  date: ad.date,
                  shift: ad.shift, // Ensure you're passing actual shift
                  views: 50, // Placeholder value
                  phoneNumber: "1234567890", // Placeholder value
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
}*/
