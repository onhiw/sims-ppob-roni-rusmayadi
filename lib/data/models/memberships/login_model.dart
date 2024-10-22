import 'package:equatable/equatable.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/memberships/login.dart';

class LoginModel extends Equatable {
  final String? token;

  const LoginModel({
    this.token,
  });

  Login toEntity() => Login(token: token);

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };

  @override
  List<Object?> get props => [token];
}
