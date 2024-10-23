import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:sims_ppob_roni_rusmayadi/common/exception.dart';
import 'package:sims_ppob_roni_rusmayadi/common/failure.dart';
import 'package:sims_ppob_roni_rusmayadi/data/datasources/information_remote_data_source.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/informations/banner_r.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/informations/services_r.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/repositories/infomation_repository.dart';

class InformationRepositoryImpl extends InformationRepository {
  final InformationRemoteDataSource informationRemoteDataSource;

  InformationRepositoryImpl({required this.informationRemoteDataSource});

  @override
  Future<Either<Failure, BannerR>> getBanner() async {
    try {
      final result = await informationRemoteDataSource.getBanner();
      return Right(result.toEntity());
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    } on FormatException {
      return const Left(ServerFailure('Oops, Invalid format'));
    } on SocketException {
      return const Left(ServerFailure(
          'Oops, An error occurred while connecting to the server'));
    }
  }

  @override
  Future<Either<Failure, ServicesR>> getServices() async {
    try {
      final result = await informationRemoteDataSource.getServices();
      return Right(result.toEntity());
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    } on FormatException {
      return const Left(ServerFailure('Oops, Invalid format'));
    } on SocketException {
      return const Left(ServerFailure(
          'Oops, An error occurred while connecting to the server'));
    }
  }
}
