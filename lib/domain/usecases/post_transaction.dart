import 'package:dartz/dartz.dart';
import 'package:sims_ppob_roni_rusmayadi/common/failure.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/transactions/transaction_detail_r.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/repositories/transaction_repository.dart';

class PostTransaction {
  final TransactionRepository membershipRepository;

  PostTransaction(this.membershipRepository);

  Future<Either<Failure, TransactionDetailR>> execute(String serviceCode) {
    return membershipRepository.postTransaction(serviceCode);
  }
}
