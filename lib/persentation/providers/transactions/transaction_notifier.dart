import 'package:flutter/material.dart';
import 'package:sims_ppob_roni_rusmayadi/common/state_enum.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/transactions/transaction_detail_r.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/usecases/post_transaction.dart';

class TransactionNotifier extends ChangeNotifier {
  final PostTransaction postTransaction;

  TransactionNotifier({required this.postTransaction});

  late TransactionDetailR _transactionDetail;
  TransactionDetailR get transactionDetail => _transactionDetail;

  RequestState _transactionDetailState = RequestState.Empty;
  RequestState get transactionDetailState => _transactionDetailState;

  String _message = '';
  String get message => _message;

  Future<void> posttransactionDetailProcess(String serviceCode) async {
    _transactionDetailState = RequestState.Loading;
    notifyListeners();
    final transactionDetailResult = await postTransaction.execute(serviceCode);

    transactionDetailResult.fold((failure) {
      _transactionDetailState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (transactionDetailR) {
      _transactionDetail = transactionDetailR;
      notifyListeners();
      _transactionDetailState = RequestState.Loaded;
      notifyListeners();
    });
  }
}
