import 'package:equatable/equatable.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/informations/banner.dart';

class BannerR extends Equatable {
  final int? status;
  final String? message;
  final List<Banner>? data;

  const BannerR({
    this.status,
    this.message,
    this.data,
  });

  @override
  List<Object?> get props => [status, message, data];
}
