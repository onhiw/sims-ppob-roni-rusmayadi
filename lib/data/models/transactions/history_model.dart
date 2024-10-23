import 'package:equatable/equatable.dart';
import 'package:sims_ppob_roni_rusmayadi/data/models/transactions/record_history_model.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/transactions/history.dart';

class HistoryModel extends Equatable {
  final String? offset;
  final String? limit;
  final List<RecordHistoryModel>? records;

  const HistoryModel({
    this.offset,
    this.limit,
    this.records,
  });

  History toEntity() => History(
        offset: offset,
        limit: limit,
        records: records?.map((e) => e.toEntity()).toList(),
      );

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        offset: json["offset"],
        limit: json["limit"],
        records: json["records"] == null
            ? []
            : List<RecordHistoryModel>.from(
                json["records"]!.map((x) => RecordHistoryModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "offset": offset,
        "limit": limit,
        "records": records == null
            ? []
            : List<dynamic>.from(records!.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [
        offset,
        limit,
        records,
      ];
}
