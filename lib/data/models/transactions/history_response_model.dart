import 'package:equatable/equatable.dart';
import 'package:sims_ppob_roni_rusmayadi/data/models/transactions/history_model.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/transactions/history_r.dart';

class HistoryResponeModel extends Equatable {
  final int? status;
  final String? message;
  final HistoryModel? data;

  const HistoryResponeModel({
    this.status,
    this.message,
    this.data,
  });

  HistoryR toEntity() => HistoryR(
        status: status,
        message: message,
        data: data?.toEntity(),
      );

  factory HistoryResponeModel.fromJson(Map<String, dynamic> json) =>
      HistoryResponeModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : HistoryModel.fromJson(json["data"]),
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
