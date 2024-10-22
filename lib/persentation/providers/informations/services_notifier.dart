import 'package:flutter/material.dart';
import 'package:sims_ppob_roni_rusmayadi/common/state_enum.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/informations/services_r.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/usecases/get_services.dart';

class ServicesNotifier extends ChangeNotifier {
  final GetServices getServices;

  ServicesNotifier({required this.getServices});

  late ServicesR _services;
  ServicesR get services => _services;

  RequestState _servicesState = RequestState.Empty;
  RequestState get servicesState => _servicesState;

  String _message = '';
  String get message => _message;

  Future<void> fetchServices() async {
    _servicesState = RequestState.Loading;
    notifyListeners();
    final servicesResult = await getServices.execute();

    servicesResult.fold((failure) {
      _servicesState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (servicesR) {
      _services = servicesR;
      notifyListeners();
      _servicesState = RequestState.Loaded;
      notifyListeners();
    });
  }
}
