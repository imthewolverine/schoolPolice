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

