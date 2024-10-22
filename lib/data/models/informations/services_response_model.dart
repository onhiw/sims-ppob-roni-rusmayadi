import 'package:equatable/equatable.dart';
import 'package:sims_ppob_roni_rusmayadi/data/models/informations/services_model.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/informations/services_r.dart';

class ServicesResponseModel extends Equatable {
  final int? status;
  final String? message;
  final List<ServicesModel>? data;

  const ServicesResponseModel({
    this.status,
    this.message,
    this.data,
  });

  ServicesR toEntity() => ServicesR(
        status: status,
        message: message,
        data: data?.map((e) => e.toEntity()).toList(),
      );

  factory ServicesResponseModel.fromJson(Map<String, dynamic> json) =>
      ServicesResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<ServicesModel>.from(
                json["data"]!.map((x) => ServicesModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [
        status,
        message,
        data,
      ];
}
