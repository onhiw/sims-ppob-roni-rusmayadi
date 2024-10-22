import 'package:equatable/equatable.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/transactions/balance.dart';

class BalanceR extends Equatable {
  final int? status;
  final String? message;
  final Balance? data;

  const BalanceR({
    this.status,
    this.message,
    this.data,
  });

  @override
  List<Object?> get props => [status, message, data];
}
