import 'package:equatable/equatable.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/transactions/record_history.dart';

class RecordHistoryModel extends Equatable {
  final String? invoiceNumber;
  final String? transactionType;
  final String? description;
  final int? totalAmount;
  final DateTime? createdOn;

  const RecordHistoryModel({
    this.invoiceNumber,
    this.transactionType,
    this.description,
    this.totalAmount,
    this.createdOn,
  });

  RecordHistory toEntity() => RecordHistory(
        invoiceNumber: invoiceNumber,
        transactionType: transactionType,
        description: description,
        totalAmount: totalAmount,
        createdOn: createdOn,
      );

  factory RecordHistoryModel.fromJson(Map<String, dynamic> json) =>
      RecordHistoryModel(
        invoiceNumber: json["invoice_number"],
        transactionType: json["transaction_type"],
        description: json["description"],
        totalAmount: json["total_amount"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
      );

  Map<String, dynamic> toJson() => {
        "invoice_number": invoiceNumber,
        "transaction_type": transactionType,
        "description": description,
        "total_amount": totalAmount,
        "created_on": createdOn?.toIso8601String(),
      };

  @override
  List<Object?> get props => [
        invoiceNumber,
        transactionType,
        description,
        totalAmount,
        createdOn,
      ];
}
