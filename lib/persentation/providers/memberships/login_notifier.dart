import 'package:flutter/material.dart';
import 'package:sims_ppob_roni_rusmayadi/common/state_enum.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/memberships/login_r.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/usecases/post_login.dart';

class LoginNotifier extends ChangeNotifier {
  final PostLogin postLogin;

  LoginNotifier({required this.postLogin});

  late LoginR _login;
  LoginR get login => _login;

  RequestState _loginState = RequestState.Empty;
  RequestState get loginState => _loginState;

  String _message = '';
  String get message => _message;

  Future<void> postLoginProcess(String email, String password) async {
    _loginState = RequestState.Loading;
    notifyListeners();
    final loginResult = await postLogin.execute(email, password);

    loginResult.fold((failure) {
      _loginState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (loginR) {
      _login = loginR;
      notifyListeners();
      _loginState = RequestState.Loaded;
      notifyListeners();
    });
  }
}
