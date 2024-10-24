import 'package:flutter/widgets.dart';
import 'package:sims_ppob_roni_rusmayadi/common/state_enum.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/transactions/history_r.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/transactions/record_history.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/usecases/get_history.dart';

class HistoryNotifier extends ChangeNotifier {
  final GetHistory getHistory;

  HistoryNotifier({required this.getHistory});

  late HistoryR _history;
  HistoryR get history => _history;

  List<RecordHistory> _records = [];
  List<RecordHistory> get records => _records;

  RequestState _historyState = RequestState.Empty;
  RequestState get historyState => _historyState;

  String _message = '';
  String get message => _message;

  Future<void> fetchhistory(int offset, int limit) async {
    _historyState = RequestState.Loading;
    notifyListeners();
    final historyResult = await getHistory.execute(offset, limit);

    historyResult.fold((failure) {
      _historyState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (historyR) {
      _history = historyR;
      notifyListeners();
      if (_history.data!.records!.isEmpty) {
        _historyState = RequestState.Empty;
        notifyListeners();
      } else {
        _records.addAll(_history.data!.records!);
        notifyListeners();
        _historyState = RequestState.Loaded;
        notifyListeners();
      }
    });
  }

  Future<void> clearHistory() async {
    _records.clear();
    notifyListeners();
  }
}
