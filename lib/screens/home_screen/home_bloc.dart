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
    try {
      await _databaseHelper.insertAd(event.newAd); // Insert new ad into database
      print('Ad inserted successfully.');
      // Add the new ad to the list
      _ads.add(event.newAd);
      print('Current ads count: ${_ads.length}');
      // Emit a new state with the updated list
      emit(HomeLoaded(ads: List.from(_ads)));// Create a fresh copy of the list
    } catch (e) {
      emit(HomeError('Failed to add new ad'));
    }
  }
}
