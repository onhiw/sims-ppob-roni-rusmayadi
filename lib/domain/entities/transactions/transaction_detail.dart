import 'package:equatable/equatable.dart';

class TransactionDetail extends Equatable {
  final String? invoiceNumber;
  final String? serviceCode;
  final String? serviceName;
  final String? transactionType;
  final int? totalAmount;
  final DateTime? createdOn;

  const TransactionDetail({
    this.invoiceNumber,
    this.serviceCode,
    this.serviceName,
    this.transactionType,
    this.totalAmount,
    this.createdOn,
  });

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
