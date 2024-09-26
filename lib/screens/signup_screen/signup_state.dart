import 'dart:io';

import 'package:equatable/equatable.dart';

class SignupState extends Equatable {
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final int phoneNumber;
  final String password;
  final String confirmPassword;
  final File? image;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String errorMessage;

  const SignupState({
    this.username = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.phoneNumber = 0,
    this.password = '',
    this.confirmPassword = '',
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isFailure = false,
    this.errorMessage = '',
    this.image,
  });

  SignupState copyWith({
    String? username,
    String? firstName,
    String? lastName,
    String? email,
    int? phoneNumber,
    String? password,
    String? confirmPassword,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
    String? errorMessage,
    File? image,
  }) {
    return SignupState(
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      errorMessage: errorMessage ?? this.errorMessage,
      image: image ?? this.image,
    );
  }

  @override
  List<Object?> get props => [
        username,
        firstName,
        lastName,
        email,
        phoneNumber,
        password,
        confirmPassword,
        isSubmitting,
        isSuccess,
        isFailure,
        errorMessage,
        image,
      ];
}
