import 'package:equatable/equatable.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/transactions/record_history.dart';

class History extends Equatable {
  final int? offset;
  final int? limit;
  final List<RecordHistory>? records;

  const History({
    this.offset,
    this.limit,
    this.records,
  });

  @override
  List<Object?> get props => [offset, limit, records];
}
