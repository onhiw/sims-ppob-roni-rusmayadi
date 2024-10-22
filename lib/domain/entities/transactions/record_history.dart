import 'package:equatable/equatable.dart';

class RecordHistory extends Equatable {
  final String? invoiceNumber;
  final String? transactionType;
  final String? description;
  final int? totalAmount;
  final DateTime? createdOn;

  const RecordHistory({
    this.invoiceNumber,
    this.transactionType,
    this.description,
    this.totalAmount,
    this.createdOn,
  });

  @override
  List<Object?> get props => [
        invoiceNumber,
        transactionType,
        description,
        totalAmount,
        createdOn,
      ];
}
