import 'package:dartz/dartz.dart';
import 'package:sims_ppob_roni_rusmayadi/common/failure.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/informations/banner_r.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/informations/services_r.dart';

abstract class InformationRepository {
  Future<Either<Failure, BannerR>> getBanner();
  Future<Either<Failure, ServicesR>> getServices();
}
