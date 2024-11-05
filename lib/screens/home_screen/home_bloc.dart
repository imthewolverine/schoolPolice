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
            userName: 'Gigi',
            profilePic: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSxSycPmZ67xN1lxHxyMYOUPxZObOxnkLf6w&s',
            address: '24-р сургууль',
            additionalInfo: '''
    This job requires a highly skilled and experienced individual who is passionate about working with students. The successful candidate will be responsible for ensuring safe and timely transportation of students to and from school, managing communications with parents, and coordinating schedules with school authorities.

    Key Responsibilities:
    - Safely transport students along the assigned route.
    - Communicate effectively with parents and school staff.
    - Ensure vehicle safety and perform regular maintenance checks.

    Preferred Qualifications:
    - Minimum of 3 years of driving experience.
    - Good communication skills.
    - Experience working with children is a plus.

    Working hours are flexible but will generally align with school hours. We’re looking for someone who is committed, reliable, and ready to be a part of our team in providing excellent service to our school community.
  ''',
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
