import 'package:equatable/equatable.dart';
import 'package:school_police/lib/models/ad.dart';

import '../../models/ad.dart'; // Import the Ad model

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class LoadAds extends HomeEvent {
  @override
  List<Object> get props => [];
}

class AddNewAd extends HomeEvent {
  final Ad newAd;

  const AddNewAd(this.newAd);

  @override
  List<Object> get props => [newAd];
}
