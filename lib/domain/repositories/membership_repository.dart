import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sims_ppob_roni_rusmayadi/common/failure.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/memberships/login_r.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/memberships/user_r.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/message.dart';

abstract class MembershipRepository {
  Future<Either<Failure, UserR>> getProfile();
  Future<Either<Failure, LoginR>> postLogin(String email, String password);
  Future<Either<Failure, Message>> postRegister(
      String email, String firstname, String lastname, String password);
  Future<Either<Failure, UserR>> putProfile(String firstname, String lastname);
  Future<Either<Failure, UserR>> putImageProfile(XFile image);
}
