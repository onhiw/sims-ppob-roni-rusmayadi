import 'package:equatable/equatable.dart';

class Services extends Equatable {
  final String? serviceCode;
  final String? serviceName;
  final String? serviceIcon;
  final int? serviceTariff;

  const Services({
    this.serviceCode,
    this.serviceName,
    this.serviceIcon,
    this.serviceTariff,
  });

  @override
  List<Object?> get props => [];
}
