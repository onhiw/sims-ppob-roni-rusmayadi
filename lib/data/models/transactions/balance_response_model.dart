import 'package:equatable/equatable.dart';
import 'package:sims_ppob_roni_rusmayadi/data/models/transactions/balance_model.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/transactions/balance_r.dart';

class BalanceResponseModel extends Equatable {
  final int? status;
  final String? message;
  final BalanceModel? data;

  const BalanceResponseModel({
    this.status,
    this.message,
    this.data,
  });

  BalanceR toEntity() =>
      BalanceR(status: status, message: message, data: data?.toEntity());

  factory BalanceResponseModel.fromJson(Map<String, dynamic> json) =>
      BalanceResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : BalanceModel.fromJson(json["data"]),
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
