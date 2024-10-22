import 'package:equatable/equatable.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/transactions/history.dart';

class HistoryR extends Equatable {
  final int? status;
  final String? message;
  final History? data;

  const HistoryR({
    this.status,
    this.message,
    this.data,
  });

  @override
  List<Object?> get props => [
        status,
        message,
        data,
      ];
}
