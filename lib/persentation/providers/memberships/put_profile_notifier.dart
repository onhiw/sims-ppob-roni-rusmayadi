import 'package:flutter/material.dart';
import 'package:sims_ppob_roni_rusmayadi/common/state_enum.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/memberships/user_r.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/usecases/put_profile.dart';

class PutProfileNotifier extends ChangeNotifier {
  final PutProfile putProfile;

  PutProfileNotifier({required this.putProfile});

  late UserR _user;
  UserR get user => _user;

  RequestState _userState = RequestState.Empty;
  RequestState get userState => _userState;

  String _message = '';
  String get message => _message;

  Future<void> putUserProcess(String firstname, String lastname) async {
    _userState = RequestState.Loading;
    notifyListeners();
    final userResult = await putProfile.execute(firstname, lastname);

    userResult.fold((failure) {
      _userState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (userR) {
      _user = userR;
      notifyListeners();
      _userState = RequestState.Loaded;
      notifyListeners();
    });
  }
}
