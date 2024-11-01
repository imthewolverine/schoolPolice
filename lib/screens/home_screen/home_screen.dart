import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../notification_screen/notification_screen.dart';
import '../profile_screen/profile_screen.dart';
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
      create: (_) => HomeBloc()..add(LoadAds()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            children: [
              IconButton(
                icon: CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSxSycPmZ67xN1lxHxyMYOUPxZObOxnkLf6w&s',
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()));
                },
              ),
              Expanded(
                child: _buildSearchSection(context),
              ),
              IconButton(
                icon: Icon(Icons.notifications, color: Colors.black),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationScreen()));
                },
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Column(
              children: [
                _buildTopSection(context),
                Expanded(
                  child: BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state is HomeLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is HomeLoaded) {
                        return _buildAdList(context, state.ads);
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
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddPostScreen()),
                    );
                  },
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Icon(Icons.add, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Хайх...',
          fillColor: Colors.grey[200],
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Icon(Icons.search, color: Colors.black),
        ),
        onChanged: (query) {
          // Search functionality
        },
      ),
    );
  }

  Widget _buildTopSection(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150,
          margin: EdgeInsets.symmetric(vertical: 10),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildAdBanner(
                  'https://popartmediagroup.co.uk/wp-content/uploads/2019/12/santaclauscoke-944x531.jpg.webp'),
              _buildAdBanner(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvjId5ED74jYnBlek4hJ1jR5tOSeZ0V2KuXQ&s'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAdBanner(String imageUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Image.network(imageUrl),
    );
  }

  Widget _buildAdList(BuildContext context, List<Ad> ads) {
    return ListView.builder(
      itemCount: ads.length,
      itemBuilder: (context, index) {
        final ad = ads[index];
        return _buildAdCard(context, ad);
      },
    );
  }

  Widget _buildAdCard(BuildContext context, Ad ad) {
    return Card(
      margin: const EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                ad.profilePic,
              ),
            ),
            const SizedBox(width: 12.0),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ad.address,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        ad.date,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Үнэ / Хөлс', style: TextStyle(color: Colors.grey)),
                          const SizedBox(height: 4.0),
                          Text(
                            '${ad.price}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color(0xFF00204A)),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Ээлж  ', style: TextStyle(color: Colors.grey)),
                          const SizedBox(height: 4.0),
                          Row(
                            children: [
                              Icon(Icons.access_time,
                                  color: Colors.amber, size: 16),
                              const SizedBox(width: 5.0),
                              Text(ad.shift, style: TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdDescriptionScreen(
                        adId: ad.id,
                        userName: ad.userName,
                        profilePic: ad.profilePic,
                        address: ad.address,
                        details: ad.additionalInfo,
                        price: ad.price,
                        date: ad.date,
                        shift: ad.shift,
                        views: ad.views,
                        requestCount: ad.requestCount, // Ensure requestCount is passed
                        phoneNumber: "1234567890",
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF00204A),
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
