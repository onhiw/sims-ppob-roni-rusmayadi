import 'package:dartz/dartz.dart';
import 'package:sims_ppob_roni_rusmayadi/common/failure.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/message.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/repositories/membership_repository.dart';

class PostRegister {
  final MembershipRepository membershipRepository;

  PostRegister(this.membershipRepository);

  Future<Either<Failure, Message>> execute(
      String email, String firstname, String lastname, String password) {
    return membershipRepository.postRegister(
        email, firstname, lastname, password);
  }
}
