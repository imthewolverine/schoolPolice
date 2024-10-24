part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String token;

  const LoginSuccess({required this.token});

  @override
  List<Object> get props => [token];
}

class LoginFailure extends LoginState {
  final String message;

  const LoginFailure({required this.message});

  @override
  List<Object> get props => [message];
}

// State to manage password visibility
class ObscurePasswordState extends LoginState {
  final bool obscurePassword;

  const ObscurePasswordState({required this.obscurePassword});

  @override
  List<Object> get props => [obscurePassword];
}
