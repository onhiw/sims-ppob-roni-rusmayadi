import 'package:equatable/equatable.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/transactions/transaction_detail.dart';

class TransactionDetailR extends Equatable {
  final int? status;
  final String? message;
  final TransactionDetail? data;

  const TransactionDetailR({
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
