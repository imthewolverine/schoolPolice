import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_post_event.dart';
import 'add_post_state.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  AddPostBloc() : super(AddPostInitial()) {
    on<SubmitPostEvent>((event, emit) async {
      emit(AddPostLoading());
      try {
        await Future.delayed(Duration(seconds: 2));
        emit(AddPostSuccess());
      } catch (e) {
        emit(AddPostFailure(error: 'Failed to submit post'));
      }
    });
  }
}
