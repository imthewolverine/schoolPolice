import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/database_helper.dart';
import 'home_event.dart';
import 'home_state.dart';
import '../../models/ad.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<Ad> _ads = [];
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  static final List<Ad> exampleAds = [
    Ad(
      id: '1',
      userId: '1', // Set userId for each ad
      userName: 'John Doe',
      profilePic: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSxSycPmZ67xN1lxHxyMYOUPxZObOxnkLf6w&s',
      address: '5-р сургууль',
      price: '50000',
      date: '2024-10-10',
      shift: '07:30-12:30',
      additionalInfo: '''
        This job requires a highly skilled and experienced individual who is passionate about working with students...
      ''',
    ),
    // Additional example ads with unique userId values
  ];

  HomeBloc() : super(HomeLoading()) {
    on<LoadAds>(_onLoadAds);
    on<AddNewAd>(_onAddNewAd);
    on<SearchAds>(_onSearchAds);
  }

  void _onLoadAds(LoadAds event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      _ads = await _databaseHelper.getAds();

      // Use example ads if the database is empty
      if (_ads.isEmpty) {
        _ads = exampleAds;
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
      _ads = await _databaseHelper.getAds();
      if (_ads.isEmpty) {
        _ads = exampleAds;
      }
      emit(HomeLoaded(ads: _ads));
    } catch (e) {
      emit(HomeError('Failed to add new ad'));
    }
  }

  void _onSearchAds(SearchAds event, Emitter<HomeState> emit) {
    final query = event.query.toLowerCase();
    final filteredAds = _ads.where((ad) {
      return ad.userName.toLowerCase().contains(query) ||
          ad.address.toLowerCase().contains(query) ||
          ad.additionalInfo.toLowerCase().contains(query);
    }).toList();

    emit(HomeLoaded(ads: filteredAds, isSearchResult: true));
  }
}

