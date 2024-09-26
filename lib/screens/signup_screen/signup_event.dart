import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignupImageChanged extends SignupEvent {
  final File image;

  const SignupImageChanged(this.image);

  @override
  List<Object> get props => [image];
}

class SignupUsernameChanged extends SignupEvent {
  final String username;

  const SignupUsernameChanged(this.username);

  @override
  List<Object> get props => [username];
}

class SignupFirstNameChanged extends SignupEvent {
  final String firstName;

  const SignupFirstNameChanged(this.firstName);

  @override
  List<Object> get props => [firstName];
}

class SignupLastNameChanged extends SignupEvent {
  final String lastName;

  const SignupLastNameChanged(this.lastName);

  @override
  List<Object> get props => [lastName];
}

class SignupEmailChanged extends SignupEvent {
  final String email;

  const SignupEmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class SignupPhoneNumberChanged extends SignupEvent {
  final int phoneNumber;

  const SignupPhoneNumberChanged(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}

class SignupPasswordChanged extends SignupEvent {
  final String password;

  const SignupPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class SignupPasswordAgainChanged extends SignupEvent {
  final String confirmPassword;

  const SignupPasswordAgainChanged(this.confirmPassword);

  @override
  List<Object> get props => [confirmPassword];
}

class SignupSubmitted extends SignupEvent {}
