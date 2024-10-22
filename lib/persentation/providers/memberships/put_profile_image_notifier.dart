import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sims_ppob_roni_rusmayadi/common/state_enum.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/memberships/user_r.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/usecases/put_profile_image.dart';

class PutProfileImageNotifier extends ChangeNotifier {
  final PutProfileImage putProfileImage;

  PutProfileImageNotifier({required this.putProfileImage});

  late UserR _user;
  UserR get user => _user;

  RequestState _userState = RequestState.Empty;
  RequestState get userState => _userState;

  String _message = '';
  String get message => _message;

  Future<void> putUserProcess(File image) async {
    _userState = RequestState.Loading;
    notifyListeners();
    final userResult = await putProfileImage.execute(image);

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
