import 'package:flutter/material.dart';
import 'package:sims_ppob_roni_rusmayadi/common/state_enum.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/transactions/balance_r.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/usecases/get_balance.dart';

class BalanceNotifier extends ChangeNotifier {
  final GetBalance getBalance;

  BalanceNotifier({required this.getBalance});

  late BalanceR _balance;
  BalanceR get balance => _balance;

  RequestState _balanceState = RequestState.Empty;
  RequestState get balanceState => _balanceState;

  String _message = '';
  String get message => _message;

  Future<void> fetchBalance() async {
    _balanceState = RequestState.Loading;
    notifyListeners();
    final balanceResult = await getBalance.execute();

    balanceResult.fold((failure) {
      _balanceState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (balanceR) {
      _balance = balanceR;
      notifyListeners();
      _balanceState = RequestState.Loaded;
      notifyListeners();
    });
  }
}
