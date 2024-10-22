import 'package:dartz/dartz.dart';
import 'package:sims_ppob_roni_rusmayadi/common/failure.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/transactions/balance_r.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/repositories/transaction_repository.dart';

class GetBalance {
  final TransactionRepository transactionRepository;

  GetBalance(this.transactionRepository);

  Future<Either<Failure, BalanceR>> execute() {
    return transactionRepository.getBalance();
  }
}
