import 'package:flutter/material.dart';
import 'package:sims_ppob_roni_rusmayadi/common/state_enum.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/message.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/usecases/post_register.dart';

class RegisterNotifier extends ChangeNotifier {
  final PostRegister postRegister;

  RegisterNotifier({required this.postRegister});

  late Message _message;
  Message get message => _message;

  RequestState _messageState = RequestState.Empty;
  RequestState get messageState => _messageState;

  String _messageErr = '';
  String get messageErr => _messageErr;

  Future<void> postRegisterProcess(
      String email, String firstname, String lastname, String password) async {
    _messageState = RequestState.Loading;
    notifyListeners();
    final loginResult =
        await postRegister.execute(email, firstname, lastname, password);

    loginResult.fold((failure) {
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
