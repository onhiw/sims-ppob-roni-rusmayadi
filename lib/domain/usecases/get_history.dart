import 'package:dartz/dartz.dart';
import 'package:sims_ppob_roni_rusmayadi/common/failure.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/transactions/history_r.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/repositories/transaction_repository.dart';

class GetHistory {
  final TransactionRepository transactionRepository;

  GetHistory(this.transactionRepository);

  Future<Either<Failure, HistoryR>> execute(int offset, int limit) {
    return transactionRepository.getHistory(offset, limit);
  }
}
