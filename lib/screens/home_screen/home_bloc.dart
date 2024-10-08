import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/database_helper.dart';
import 'home_event.dart';
import 'home_state.dart';
import '../../models/ad.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<Ad> _ads = []; // List of ads using the Ad model
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  HomeBloc() : super(HomeLoading()) {
    on<LoadAds>(_onLoadAds);
    on<AddNewAd>(_onAddNewAd);
  }

  // Handle the event to load ads
  void _onLoadAds(LoadAds event, Emitter<HomeState> emit) async {
    emit(HomeLoading()); // Emit the loading state
    try {
      _ads = await _databaseHelper.getAds(); // Fetch ads from database
      emit(HomeLoaded(ads: _ads));
// Simulate a delay to fetch ads (replace this with real data fetching logic)
      /* await Future.delayed(Duration(seconds: 1));
      _ads = _fetchAds(); // Fetch the initial list of ads
      emit(HomeLoaded(ads: _ads)); */ // Emit the loaded ads
    } catch (e) {
      emit(HomeError('Failed to load ads')); // Handle error case
    }
  }

  // Handle the event to add a new ad
  Future<void> _onAddNewAd(AddNewAd event, Emitter<HomeState> emit) async {
    print('Adding new ad: ${event.newAd}');
    try {
      await _databaseHelper.insertAd(event.newAd); // Insert new ad into database
      print('Ad inserted successfully.');
      // Add the new ad to the list
      _ads.add(event.newAd);
      print('Current ads count: ${_ads.length}');
      // Emit a new state with the updated list
      emit(HomeLoaded(ads: List.from(_ads)));// Create a fresh copy of the list
    } catch (e) {
      print('Error inserting ad: $e');
      emit(HomeError('Failed to add new ad'));
    }
  }

  // Mock data fetching method for ads
  List<Ad> _fetchAds() {
    // You can replace this mock data with real data fetching logic
    return [
      Ad(
        id: '1',
        userName: 'John Doe',
        profilePic: 'https://example.com/profile.jpg',
        address: '123 School St',
        price: '50 USD',
        date: '2024-09-30',
        additionalInfo: 'Need safe person',
        shift: 'morning',
      ),
      Ad(
        id: '2',
        userName: 'Jane Smith',
        profilePic: 'https://example.com/profile2.jpg',
        address: '456 High School St',
        price: '60 USD',
        date: '2024-10-01',
        additionalInfo: 'Experienced officer needed',
        shift: 'day',
      ),
    ];
  }
}
