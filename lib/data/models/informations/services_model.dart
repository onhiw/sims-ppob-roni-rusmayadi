import 'package:equatable/equatable.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/informations/services.dart';

class ServicesModel extends Equatable {
  final String? serviceCode;
  final String? serviceName;
  final String? serviceIcon;
  final int? serviceTariff;

  const ServicesModel({
    this.serviceCode,
    this.serviceName,
    this.serviceIcon,
    this.serviceTariff,
  });

  Services toEntity() => Services(
        serviceCode: serviceCode,
        serviceName: serviceName,
        serviceIcon: serviceIcon,
        serviceTariff: serviceTariff,
      );

  factory ServicesModel.fromJson(Map<String, dynamic> json) => ServicesModel(
        serviceCode: json["service_code"],
        serviceName: json["service_name"],
        serviceIcon: json["service_icon"],
        serviceTariff: json["service_tariff"],
      );

  Map<String, dynamic> toJson() => {
        "service_code": serviceCode,
        "service_name": serviceName,
        "service_icon": serviceIcon,
        "service_tariff": serviceTariff,
      };

  @override
  List<Object?> get props => [
        serviceCode,
        serviceName,
        serviceIcon,
        serviceTariff,
      ];
}
