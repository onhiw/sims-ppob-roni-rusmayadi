import 'package:equatable/equatable.dart';
import 'package:sims_ppob_roni_rusmayadi/data/models/memberships/login_model.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/memberships/login_r.dart';

class LoginResponseModel extends Equatable {
  final int? status;
  final String? message;
  final LoginModel? data;

  const LoginResponseModel({
    this.status,
    this.message,
    this.data,
  });

  LoginR toEntity() =>
      LoginR(status: status, message: message, data: data?.toEntity());

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : LoginModel.fromJson(json["data"]),
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
