import 'package:equatable/equatable.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/informations/services.dart';

class ServicesR extends Equatable {
  final int? status;
  final String? message;
  final List<Services>? data;

  const ServicesR({
    this.status,
    this.message,
    this.data,
  });

  @override
  List<Object?> get props => [status, message, data];
}
