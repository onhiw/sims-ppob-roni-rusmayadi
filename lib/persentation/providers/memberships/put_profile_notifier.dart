import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sims_ppob_roni_rusmayadi/common/state_enum.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/memberships/user_r.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/usecases/put_profile.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/usecases/put_profile_image.dart';

class PutProfileNotifier extends ChangeNotifier {
  final PutProfile putProfile;
  final PutProfileImage putProfileImage;

  PutProfileNotifier({required this.putProfile, required this.putProfileImage});

  late UserR _userPut;
  UserR get userPut => _userPut;

  RequestState _userPutState = RequestState.Empty;
  RequestState get userPutState => _userPutState;

  String _message = '';
  String get message => _message;

  Future<void> putUserProcess(
      String firstname, String lastname, XFile? image) async {
    _userPutState = RequestState.Loading;
    notifyListeners();
    final userResult = await putProfile.execute(firstname, lastname);
    dynamic userImage;

    if (image != null) {
      userImage = await putProfileImage.execute(image);
    }

    userResult.fold((failure) {
      _userPutState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (userR) {
      if (image != null) {
        userImage.fold((failure) {
          _userPutState = RequestState.Error;
          _message = failure.message;
          notifyListeners();
        }, (userR) {
          _userPut = userR;
          notifyListeners();
          _userPutState = RequestState.Loaded;
          notifyListeners();
        });
      } else {
        _userPut = userR;
        notifyListeners();
        _userPutState = RequestState.Loaded;
        notifyListeners();
      }
    });
  }
}
