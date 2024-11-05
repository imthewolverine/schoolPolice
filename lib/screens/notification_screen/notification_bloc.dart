import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/notification.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial()) {
    on<LoadNotifications>(_onLoadNotifications);
    on<AddNotification>(_onAddNotification);
  }

  void _onLoadNotifications(LoadNotifications event, Emitter<NotificationState> emit) async {
    try {
      // Simulate fetching notifications. Replace with actual data source.
      final notifications = List.generate(
        10,
            (index) => NotificationModel(
          id: '$index',
          title: 'Баталгаажсан',
          message: '5-р сургуульд school police хийх хүсэлт баталгаажсан байна.',
          time: '9:${40 + index} AM',
          imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSxSycPmZ67xN1lxHxyMYOUPxZObOxnkLf6w&s',
        ),
      );
      emit(NotificationLoaded(notifications));
    } catch (e) {
      emit(NotificationError('Failed to load notifications'));
    }
  }

  void _onAddNotification(AddNotification event, Emitter<NotificationState> emit) {
    if (state is NotificationLoaded) {
      final updatedNotifications = List<NotificationModel>.from((state as NotificationLoaded).notifications)
        ..add(event.notification);
      emit(NotificationLoaded(updatedNotifications));
    }
  }
}
