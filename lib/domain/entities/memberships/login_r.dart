import 'package:equatable/equatable.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/memberships/login.dart';

class LoginR extends Equatable {
  final int? status;
  final String? message;
  final Login? data;

  const LoginR({
    this.status,
    this.message,
    this.data,
  });

  @override
  List<Object?> get props => [
        status,
        message,
        data,
      ];
}
