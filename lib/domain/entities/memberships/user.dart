import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? profileImage;

  const User({
    this.email,
    this.firstName,
    this.lastName,
    this.profileImage,
  });

  @override
  List<Object?> get props => [email, firstName, lastName, profileImage];
}
