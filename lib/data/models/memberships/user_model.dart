import 'package:equatable/equatable.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/memberships/user.dart';

class UserModel extends Equatable {
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? profileImage;

  const UserModel({
    this.email,
    this.firstName,
    this.lastName,
    this.profileImage,
  });

  User toEntity() => User(
        email: email,
        firstName: firstName,
        lastName: lastName,
        profileImage: profileImage,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        profileImage: json["profile_image"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "profile_image": profileImage,
      };

  @override
  List<Object?> get props => [
        email,
        firstName,
        lastName,
        profileImage,
      ];
}
