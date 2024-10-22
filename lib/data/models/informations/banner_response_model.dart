import 'package:equatable/equatable.dart';
import 'package:sims_ppob_roni_rusmayadi/data/models/informations/banner_model.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/informations/banner_r.dart';

class BannerResponseModel extends Equatable {
  final int? status;
  final String? message;
  final List<BannerModel>? data;

  const BannerResponseModel({
    this.status,
    this.message,
    this.data,
  });

  BannerR toEntity() => BannerR(
        status: status,
        message: message,
        data: data?.map((e) => e.toEntity()).toList(),
      );

  factory BannerResponseModel.fromJson(Map<String, dynamic> json) =>
      BannerResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<BannerModel>.from(
                json["data"]!.map((x) => BannerModel.fromJson(x))),
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
