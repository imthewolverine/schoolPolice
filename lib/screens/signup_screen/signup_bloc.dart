import 'package:flutter_bloc/flutter_bloc.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(const SignupState()) {
    on<SignupImageChanged>(_onImageChanged);
    on<SignupUsernameChanged>(_onUsernameChanged);
    on<SignupFirstNameChanged>(_onFirstNameChanged);
    on<SignupLastNameChanged>(_onLastNameChanged);
    on<SignupEmailChanged>(_onEmailChanged);
    on<SignupPhoneNumberChanged>(_onPhoneNumberChanged);
    on<SignupPasswordChanged>(_onPasswordChanged);
    on<SignupPasswordAgainChanged>(_onPasswordAgainChanged);
    on<SignupSubmitted>(_onSignupSubmitted);
  }

  void _onImageChanged(SignupImageChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(image: event.image));
  }

  void _onUsernameChanged(
      SignupUsernameChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(username: event.username));
  }

  void _onFirstNameChanged(
      SignupFirstNameChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(firstName: event.firstName));
  }

  void _onLastNameChanged(
      SignupLastNameChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(lastName: event.lastName));
  }

  void _onEmailChanged(SignupEmailChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onPhoneNumberChanged(
      SignupPhoneNumberChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(phoneNumber: event.phoneNumber));
  }

  void _onPasswordChanged(
      SignupPasswordChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _onPasswordAgainChanged(
      SignupPasswordAgainChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(confirmPassword: event.confirmPassword));
  }

  Future<bool> _isEmailValid(String email) async {
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return regex.hasMatch(email);
  }

  Future<bool> _isEmailUnique(String email) async {
    //api gaasaa avch shalgana
    return true;
  }

  Future<bool> _isPhoneNumberUnique(int phoneNumber) async {
    //api gaasaa avch shalgana
    return true;
  }

  bool _isPasswordValid(String password) {
    final regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{6,}$');
    return regex.hasMatch(password);
  }

  void _onSignupSubmitted(
      SignupSubmitted event, Emitter<SignupState> emit) async {
    emit(state.copyWith(isSubmitting: true));
    if (state.username.isEmpty) {
      emit(state.copyWith(
        isSubmitting: false,
        isSuccess: false,
        isFailure: true,
        errorMessage: 'Хэрэглэгчийн нэр хоосон байж болохгүй',
      ));
      emit(state.copyWith(isFailure: false));
      return;
    }

    if (await _isEmailValid(state.email) == false) {
      emit(state.copyWith(
        isSubmitting: false,
        isSuccess: false,
        isFailure: true,
        errorMessage: 'Буруу email хаяг',
      ));
      emit(state.copyWith(isFailure: false));
      return;
    }

    if (await _isEmailUnique(state.email) == false) {
      emit(state.copyWith(
        isSubmitting: false,
        isSuccess: false,
        isFailure: true,
        errorMessage: 'Бүртгэлтэй email хаяг байна',
      ));
      emit(state.copyWith(isFailure: false));
      return;
    }

    if (await _isPhoneNumberUnique(state.phoneNumber) == false) {
      emit(state.copyWith(
        isSubmitting: false,
        isSuccess: false,
        isFailure: true,
        errorMessage: 'Бүртгэлтэй утасны дугаар байна',
      ));
      emit(state.copyWith(isFailure: false));
      return;
    }

    if (state.phoneNumber.toString().length != 8) {
      emit(state.copyWith(
        isSubmitting: false,
        isSuccess: false,
        isFailure: true,
        errorMessage: 'Боломжтой утасны дугаар оруулна уу',
      ));
      emit(state.copyWith(isFailure: false));
      return;
    }

    if (_isPasswordValid(state.password) == false) {
      emit(state.copyWith(
        isSubmitting: false,
        isSuccess: false,
        isFailure: true,
        errorMessage:
            'Нууц үг хамгийн багадаа 6 тэмдэгтээс бүрдэх бөгөөд том, жижиг үсэг, тоо, тэмдэг зэргийг агуулсан байх ёстой',
      ));
      emit(state.copyWith(isFailure: false));
      return;
    }

    if (state.password != state.confirmPassword) {
      emit(state.copyWith(
        isSubmitting: false,
        isSuccess: false,
        isFailure: true,
        errorMessage: 'Нууц үг тохирохгүй байна',
      ));
      emit(state.copyWith(isFailure: false));
      return;
    }

    await Future.delayed(const Duration(seconds: 2));

    emit(state.copyWith(
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    ));
  }
}
