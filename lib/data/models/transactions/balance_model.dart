import 'package:equatable/equatable.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/transactions/balance.dart';

class BalanceModel extends Equatable {
  final int? balance;

  const BalanceModel({
    this.balance,
  });

  Balance toEntity() => Balance(balance: balance);

  factory BalanceModel.fromJson(Map<String, dynamic> json) => BalanceModel(
        balance: json["balance"],
      );

  Map<String, dynamic> toJson() => {
        "balance": balance,
      };

  @override
  List<Object?> get props => [balance];
}
