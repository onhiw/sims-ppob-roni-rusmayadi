import 'package:equatable/equatable.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/transactions/transaction_detail.dart';

class TransactionDetailModel extends Equatable {
  final String? invoiceNumber;
  final String? serviceCode;
  final String? serviceName;
  final String? transactionType;
  final int? totalAmount;
  final DateTime? createdOn;

  const TransactionDetailModel({
    this.invoiceNumber,
    this.serviceCode,
    this.serviceName,
    this.transactionType,
    this.totalAmount,
    this.createdOn,
  });

  TransactionDetail toEntity() => TransactionDetail(
        invoiceNumber: invoiceNumber,
        serviceCode: serviceCode,
        serviceName: serviceName,
        transactionType: transactionType,
        totalAmount: totalAmount,
        createdOn: createdOn,
      );

  factory TransactionDetailModel.fromJson(Map<String, dynamic> json) =>
      TransactionDetailModel(
        invoiceNumber: json["invoice_number"],
        serviceCode: json["service_code"],
        serviceName: json["service_name"],
        transactionType: json["transaction_type"],
        totalAmount: json["total_amount"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
      );

  Map<String, dynamic> toJson() => {
        "invoice_number": invoiceNumber,
        "service_code": serviceCode,
        "service_name": serviceName,
        "transaction_type": transactionType,
        "total_amount": totalAmount,
        "created_on": createdOn?.toIso8601String(),
      };

  @override
  List<Object?> get props => [
        invoiceNumber,
        serviceCode,
        serviceName,
        transactionType,
        totalAmount,
        createdOn,
      ];
}
