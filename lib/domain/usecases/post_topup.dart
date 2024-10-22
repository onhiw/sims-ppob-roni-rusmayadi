import 'package:dartz/dartz.dart';
import 'package:sims_ppob_roni_rusmayadi/common/failure.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/message.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/repositories/transaction_repository.dart';

class PostTopUp {
  final TransactionRepository transactionRepository;

  PostTopUp(this.transactionRepository);

  Future<Either<Failure, Message>> execute(int amount) {
    return transactionRepository.postTopUp(amount);
  }
}
