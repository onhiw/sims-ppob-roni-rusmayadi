import 'package:flutter/material.dart';
import 'package:sims_ppob_roni_rusmayadi/common/state_enum.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/informations/banner_r.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/usecases/get_banner.dart';

class BannerNotifier extends ChangeNotifier {
  final GetBanner getBanner;

  BannerNotifier({required this.getBanner});

  late BannerR _banner;
  BannerR get banner => _banner;

  RequestState _bannerState = RequestState.Empty;
  RequestState get bannerState => _bannerState;

  String _message = '';
  String get message => _message;

  Future<void> fetchBanner() async {
    _bannerState = RequestState.Loading;
    notifyListeners();
    final bannerResult = await getBanner.execute();

    bannerResult.fold((failure) {
      _bannerState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (bannerR) {
      _banner = bannerR;
      notifyListeners();
      _bannerState = RequestState.Loaded;
      notifyListeners();
    });
  }
}
