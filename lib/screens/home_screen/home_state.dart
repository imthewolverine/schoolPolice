import 'package:equatable/equatable.dart';

import '../../models/ad.dart';


class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Ad> ads;

  const HomeLoaded({required this.ads}); // Explicitly naming the parameter

  @override
  List<Object> get props => [ads];
}


class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}

