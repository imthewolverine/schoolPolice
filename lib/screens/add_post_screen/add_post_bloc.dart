import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_post_event.dart';
import 'add_post_state.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  AddPostBloc() : super(AddPostInitial()) {
    // Registering the event handler for SubmitPostEvent
    on<SubmitPostEvent>((event, emit) async {
      emit(AddPostLoading());  // Emit loading state

      try {
        // Simulating a delay to represent saving the post (e.g., to a database or API)
        await Future.delayed(Duration(seconds: 2));

        // After successfully saving the post, emit AddPostSuccess
        emit(AddPostSuccess());
      } catch (e) {
        // In case of an error, emit AddPostFailure with the error message
        emit(AddPostFailure(error: 'Failed to submit post'));
      }
    });
  }
}
