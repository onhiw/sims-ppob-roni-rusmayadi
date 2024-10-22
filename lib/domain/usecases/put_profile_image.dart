import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:sims_ppob_roni_rusmayadi/common/failure.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/memberships/user_r.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/repositories/membership_repository.dart';

class PutProfileImage {
  final MembershipRepository membershipRepository;

  PutProfileImage(this.membershipRepository);

  Future<Either<Failure, UserR>> execute(File image) {
    return membershipRepository.putImageProfile(image);
  }
}
