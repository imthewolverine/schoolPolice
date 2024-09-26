import 'dart:io';

class User {
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final int phoneNumber;
  final String password;
  final File? image;

  User({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    this.image,
  });

  User copyWith({
    String? username,
    String? firstName,
    String? lastName,
    String? email,
    int? phoneNumber,
    String? password,
    File? image,
  }) {
    return User(
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'image': image?.path,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      password: map['password'],
      image: map['image'] != null ? File(map['image']) : null,
    );
  }
}
