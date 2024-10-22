import 'package:dartz/dartz.dart';
import 'package:sims_ppob_roni_rusmayadi/common/failure.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/message.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/transactions/balance_r.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/transactions/history_r.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/transactions/transaction_detail_r.dart';

abstract class TransactionRepository {
  Future<Either<Failure, BalanceR>> getBalance();
  Future<Either<Failure, HistoryR>> getHistory(int offset, int limit);
  Future<Either<Failure, Message>> postTopUp(int amount);
  Future<Either<Failure, TransactionDetailR>> postTransaction(
      String serviceCode);
}
