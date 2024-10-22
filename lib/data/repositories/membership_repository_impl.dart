import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:sims_ppob_roni_rusmayadi/common/exception.dart';
import 'package:sims_ppob_roni_rusmayadi/common/failure.dart';
import 'package:sims_ppob_roni_rusmayadi/data/datasources/membership_remote_data_source.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/memberships/login_r.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/memberships/user_r.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/message.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/repositories/membership_repository.dart';

class MembershipRepositoryImpl extends MembershipRepository {
  final MembershipRemoteDataSource membershipRemoteDataSource;

  MembershipRepositoryImpl({required this.membershipRemoteDataSource});

  @override
  Future<Either<Failure, UserR>> getProfile() async {
    try {
      final result = await membershipRemoteDataSource.getProfile();
      return Right(result.toEntity());
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    } on FormatException {
      return const Left(ServerFailure(
          'Oops, An error occurred while connecting to the server'));
    } on SocketException {
      return const Left(ServerFailure(
          'Oops, An error occurred while connecting to the server'));
    }
  }

  @override
  Future<Either<Failure, LoginR>> postLogin(
      String email, String password) async {
    try {
      final result =
          await membershipRemoteDataSource.postLogin(email, password);
      return Right(result.toEntity());
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    } on FormatException {
      return const Left(ServerFailure(
          'Oops, An error occurred while connecting to the server'));
    } on SocketException {
      return const Left(ServerFailure(
          'Oops, An error occurred while connecting to the server'));
    }
  }

  @override
  Future<Either<Failure, Message>> postRegister(
      String email, String firstname, String lastname, String password) async {
    try {
      final result = await membershipRemoteDataSource.postRegister(
          email, firstname, lastname, password);
      return Right(result.toEntity());
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    } on FormatException {
      return const Left(ServerFailure(
          'Oops, An error occurred while connecting to the server'));
    } on SocketException {
      return const Left(ServerFailure(
          'Oops, An error occurred while connecting to the server'));
    }
  }

  @override
  Future<Either<Failure, UserR>> putImageProfile(File image) async {
    try {
      final result = await membershipRemoteDataSource.putProfileImage(image);
      return Right(result.toEntity());
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    } on FormatException {
      return const Left(ServerFailure(
          'Oops, An error occurred while connecting to the server'));
    } on SocketException {
      return const Left(ServerFailure(
          'Oops, An error occurred while connecting to the server'));
    }
  }

  @override
  Future<Either<Failure, UserR>> putProfile(
      String firstname, String lastname) async {
    try {
      final result =
          await membershipRemoteDataSource.putProfile(firstname, lastname);
      return Right(result.toEntity());
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    } on FormatException {
      return const Left(ServerFailure(
          'Oops, An error occurred while connecting to the server'));
    } on SocketException {
      return const Left(ServerFailure(
          'Oops, An error occurred while connecting to the server'));
    }
  }
}
