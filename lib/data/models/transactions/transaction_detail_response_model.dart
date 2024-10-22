import 'package:equatable/equatable.dart';
import 'package:sims_ppob_roni_rusmayadi/data/models/transactions/transaction_detail_model.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/transactions/transaction_detail_r.dart';

class TransactionDetailResponseModel extends Equatable {
  final int? status;
  final String? message;
  final TransactionDetailModel? data;

  const TransactionDetailResponseModel({
    this.status,
    this.message,
    this.data,
  });

  TransactionDetailR toEntity() => TransactionDetailR(
        status: status,
        message: message,
        data: data?.toEntity(),
      );

  factory TransactionDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      TransactionDetailResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : TransactionDetailModel.fromJson(json["data"]),
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
