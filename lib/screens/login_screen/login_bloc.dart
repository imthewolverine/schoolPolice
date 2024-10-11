import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_police/services/auth_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthService authService;

  // Set the initial obscurePassword state to `true`
  bool obscurePassword = true;

  LoginBloc(this.authService) : super(LoginInitial()) {
    on<Check>((event, emit) async {
      emit(LoginLoading());
      final token =
          await authService.authenticateUser(event.username, event.password);

      if (token != null) {
        emit(LoginSuccess(token: token));
      } else {
        emit(LoginFailure(message: 'Нэвтрэх нэр эсвэл нууц үг буруу байна'));
      }
    });

    // Handle the toggle password visibility event
    on<TogglePasswordVisibility>((event, emit) {
      obscurePassword = !event.obscurePassword;
      emit(ObscurePasswordState(obscurePassword: obscurePassword));
    });
  }
}
