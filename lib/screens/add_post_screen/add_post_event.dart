import 'package:equatable/equatable.dart';

// Define all the events for the AddPostBloc
abstract class AddPostEvent extends Equatable {
  const AddPostEvent();

  @override
  List<Object?> get props => [];
}

// Event for submitting the post
class SubmitPostEvent extends AddPostEvent {
  final String school;
  final String district;
  final String shift;
  final String time;
  final String salary;
  final String additionalInfo;

  SubmitPostEvent({
    required this.school,
    required this.district,
    required this.shift,
    required this.time,
    required this.salary,
    required this.additionalInfo,
  });

  @override
  List<Object?> get props => [school, district, shift, time, salary, additionalInfo];
}
