import 'package:equatable/equatable.dart';

class Balance extends Equatable {
  final int? balance;

  const Balance({
    this.balance,
  });

  @override
  List<Object?> get props => [balance];
}
