import 'package:equatable/equatable.dart';

// Define all the states for the AddPostBloc
abstract class AddPostState extends Equatable {
  const AddPostState();

  @override
  List<Object?> get props => [];
}

class AddPostInitial extends AddPostState {}

class AddPostLoading extends AddPostState {}

class AddPostSuccess extends AddPostState {}

class AddPostFailure extends AddPostState {
  final String error;

  AddPostFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
