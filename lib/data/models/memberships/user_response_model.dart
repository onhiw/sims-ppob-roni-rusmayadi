import 'package:equatable/equatable.dart';
import 'package:sims_ppob_roni_rusmayadi/data/models/memberships/user_model.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/memberships/user_r.dart';

class UserResponseModel extends Equatable {
  final int? status;
  final String? message;
  final UserModel? data;

  const UserResponseModel({
    this.status,
    this.message,
    this.data,
  });

  UserR toEntity() => UserR(
        status: status,
        message: message,
        data: data?.toEntity(),
      );

  factory UserResponseModel.fromJson(Map<String, dynamic> json) =>
      UserResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : UserModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };

  @override
  List<Object?> get props => [
        status,
        message,
        data,
      ];
}
