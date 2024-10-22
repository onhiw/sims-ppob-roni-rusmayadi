import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:sims_ppob_roni_rusmayadi/common/exception.dart';
import 'package:sims_ppob_roni_rusmayadi/common/failure.dart';
import 'package:sims_ppob_roni_rusmayadi/data/datasources/transaction_remote_data_source.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/message.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/transactions/balance_r.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/transactions/history_r.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/transactions/transaction_detail_r.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl extends TransactionRepository {
  final TransactionRemoteDataSource transactionRemoteDataSource;

  TransactionRepositoryImpl({required this.transactionRemoteDataSource});

  @override
  Future<Either<Failure, BalanceR>> getBalance() async {
    try {
      final result = await transactionRemoteDataSource.getBalance();
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
  Future<Either<Failure, HistoryR>> getHistory(int offset, int limit) async {
    try {
      final result =
          await transactionRemoteDataSource.getHistory(offset, limit);
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
  Future<Either<Failure, Message>> postTopUp(int amount) async {
    try {
      final result = await transactionRemoteDataSource.postTopUp(amount);
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
  Future<Either<Failure, TransactionDetailR>> postTransaction(
      String serviceCode) async {
    try {
      final result =
          await transactionRemoteDataSource.postTransaction(serviceCode);
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
