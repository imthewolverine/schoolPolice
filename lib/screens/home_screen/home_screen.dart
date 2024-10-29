import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_police/widgets/ad_card.dart';
import '../notification_screen/notification_screen.dart';
import '../profile_screen/profile_screen.dart';
import '../add_post_screen/add_post_screen.dart';
import '../home_screen/home_bloc.dart';
import '../home_screen/home_event.dart';
import '../../models/ad.dart';
import '../home_screen/home_state.dart';

List<Ad> exampleAds = [
  Ad(
    id: '1',
    userName: 'John Doe',
    profilePic:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSxSycPmZ67xN1lxHxyMYOUPxZObOxnkLf6w&s',
    address: '5-р сургууль',
    price: '50000',
    date: '2024-10-10',
    shift: '07:30-12:30',
    additionalInfo: 'Looking for a part-time job.',
  ),
  Ad(
    id: '2',
    userName: 'Jane Smith',
    profilePic:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvjId5ED74jYnBlek4hJ1jR5tOSeZ0V2KuXQ&s',
    address: '456 Oak Avenue, Town',
    price: '\$60/hour',
    date: '2024-10-12',
    shift: 'Evening Shift',
    additionalInfo: 'Seeking a weekend gig.',
  ),
  Ad(
    id: '3',
    userName: 'Emily Johnson',
    profilePic:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvjId5ED74jYnBlek4hJ1jR5tOSeZ0V2KuXQ&s',
    address: '789 Pine Road, Village',
    price: '\$40/hour',
    date: '2024-10-15',
    shift: 'Afternoon Shift',
    additionalInfo: 'Open for tutoring jobs.',
  ),
  Ad(
    id: '4',
    userName: 'Chris Lee',
    profilePic:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSxSycPmZ67xN1lxHxyMYOUPxZObOxnkLf6w&s',
    address: '101 Maple Drive, Suburb',
    price: '\$55/hour',
    date: '2024-10-18',
    shift: 'Night Shift',
    additionalInfo: 'Available for night shifts.',
  ),
  Ad(
    id: '5',
    userName: 'Chris Lee',
    profilePic:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSxSycPmZ67xN1lxHxyMYOUPxZObOxnkLf6w&s',
    address: '101 Maple Drive, Suburb',
    price: '\$55/hour',
    date: '2024-10-18',
    shift: 'Night Shift',
    additionalInfo: 'Available for night shifts.',
  ),
];

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: BlocProvider(
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
                    );
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
                        builder: (context) => NotificationScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        color: Colors.grey,
                        width: 1), // Grey border for inactive tabs
                  ),
                ),
                child: TabBar(
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2.0,
                    ),
                    insets: EdgeInsets.zero,
                  ),
                  labelColor: Theme.of(context).colorScheme.primary,
                  unselectedLabelColor: Colors.grey,
                  tabs: const [
                    Tab(text: 'Эцэг эх'),
                    Tab(text: 'School Police'),
                  ],
                ),
              ),
            ),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: TabBarView(
            children: [
              // "Эцэг эх" Tab - Shows ads
              Stack(
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
                              final adsToShow =
                                  state.ads.isEmpty ? exampleAds : state.ads;
                              return _buildAdList(context, adsToShow);
                            } else if (state is HomeError) {
                              return _buildAdList(context, exampleAds);
                            } else {
                              return _buildAdList(context, exampleAds);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // "School Police" Tab - Empty for now
              Center(
                child: Text(
                  'No content available for School Police',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ],
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 8,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                radius: 30,
                child: IconButton(
                  icon: Icon(Icons.add, color: Colors.white),
                  onPressed: () {
                    _showAddPostBottomSheet(context);
                  },
                ),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ),
      ),
    );
  }

  // Function to show the bottom sheet for adding a post
  void _showAddPostBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => FractionallySizedBox(
        heightFactor: 0.9,
        child: Column(
          children: [
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
              child: AddPostScreen(),
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
        return AdCard(ad: ad);
      },
    );
  }
}
