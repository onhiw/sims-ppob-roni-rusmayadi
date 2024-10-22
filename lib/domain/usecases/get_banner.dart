import 'package:dartz/dartz.dart';
import 'package:sims_ppob_roni_rusmayadi/common/failure.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/informations/banner_r.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/repositories/infomation_repository.dart';

class GetBanner {
  final InformationRepository informationRepository;

  GetBanner(this.informationRepository);

  Future<Either<Failure, BannerR>> execute() {
    return informationRepository.getBanner();
  }
}
