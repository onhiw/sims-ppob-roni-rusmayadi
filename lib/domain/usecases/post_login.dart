import 'package:dartz/dartz.dart';
import 'package:sims_ppob_roni_rusmayadi/common/failure.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/memberships/login_r.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/repositories/membership_repository.dart';

class PostLogin {
  final MembershipRepository membershipRepository;

  PostLogin(this.membershipRepository);

  Future<Either<Failure, LoginR>> execute(String email, String password) {
    return membershipRepository.postLogin(email, password);
  }
}
