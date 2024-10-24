import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sims_ppob_roni_rusmayadi/common/state_enum.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/memberships/user_r.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/usecases/put_profile_image.dart';

class PutProfileImageNotifier extends ChangeNotifier {
  final PutProfileImage putProfileImage;

  PutProfileImageNotifier({required this.putProfileImage});

  late UserR _userImage;
  UserR get userImage => _userImage;

  RequestState _userImageState = RequestState.Empty;
  RequestState get userImageState => _userImageState;

  String _message = '';
  String get message => _message;

  Future<void> putUserProcess(XFile image) async {
    _userImageState = RequestState.Loading;
    notifyListeners();
    final userResult = await putProfileImage.execute(image);

    userResult.fold((failure) {
      _userImageState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (userR) {
      _userImage = userR;
      notifyListeners();
      _userImageState = RequestState.Loaded;
      notifyListeners();
    });
  }
}
