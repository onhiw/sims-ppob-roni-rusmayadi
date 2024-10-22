import 'package:equatable/equatable.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/memberships/user.dart';

class UserR extends Equatable {
  final int? status;
  final String? message;
  final User? data;

  const UserR({
    this.status,
    this.message,
    this.data,
  });

  @override
  List<Object?> get props => [status, message, data];
}
