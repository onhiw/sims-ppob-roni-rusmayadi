import 'package:dartz/dartz.dart';
import 'package:sims_ppob_roni_rusmayadi/common/failure.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/informations/services_r.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/repositories/infomation_repository.dart';

class GetServices {
  final InformationRepository informationRepository;

  GetServices(this.informationRepository);

  Future<Either<Failure, ServicesR>> execute() {
    return informationRepository.getServices();
  }
}
