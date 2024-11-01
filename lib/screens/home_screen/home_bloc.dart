import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/database_helper.dart';
import 'home_event.dart';
import 'home_state.dart';
import '../../models/ad.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<Ad> _ads = [];
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  HomeBloc() : super(HomeLoading()) {
    on<LoadAds>(_onLoadAds);
    on<AddNewAd>(_onAddNewAd);
  }

  void _onLoadAds(LoadAds event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      _ads = await _databaseHelper.getAds();

      // Add an example ad if the database is empty
      if (_ads.isEmpty) {
        _ads.add(
          Ad(
            id: '1',
            userName: 'Example User',
            profilePic: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSxSycPmZ67xN1lxHxyMYOUPxZObOxnkLf6w&s',
            address: '24-р сургууль',
            additionalInfo: 'This is an example ad to demonstrate functionality.',
            price: '50,000',
            date: '2024-10-28',
            shift: 'Өглөө',
            views: 15,
            requestCount: 5,
          ),
        );
      }

      emit(HomeLoaded(ads: _ads));
    } catch (e) {
      emit(HomeError('Failed to load ads'));
    }
  }

  Future<void> _onAddNewAd(AddNewAd event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      await _databaseHelper.insertAd(event.newAd);
      print('Ad inserted successfully.');
      _ads = await _databaseHelper.getAds();
      emit(HomeLoaded(ads: _ads));
    } catch (e) {
      emit(HomeError('Failed to add new ad'));
    }
  }
}
