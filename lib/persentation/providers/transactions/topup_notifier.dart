import 'package:flutter/material.dart';
import 'package:sims_ppob_roni_rusmayadi/common/state_enum.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/message.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/usecases/post_topup.dart';

class TopUpNotifier extends ChangeNotifier {
  final PostTopUp postTopUp;

  TopUpNotifier({required this.postTopUp});

  late Message _message;
  Message get message => _message;

  RequestState _messageState = RequestState.Empty;
  RequestState get messageState => _messageState;

  String _messageErr = '';
  String get messageErr => _messageErr;

  Future<void> postLoginProcess(int amount) async {
    _messageState = RequestState.Loading;
    notifyListeners();
    final messageResult = await postTopUp.execute(amount);

    messageResult.fold((failure) {
      _messageState = RequestState.Error;
      _messageErr = failure.message;
      notifyListeners();
    }, (messageR) {
      _message = messageR;
      notifyListeners();
      _messageState = RequestState.Loaded;
      notifyListeners();
    });
  }
}
