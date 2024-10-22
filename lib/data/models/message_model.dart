import 'package:equatable/equatable.dart';
import 'package:sims_ppob_roni_rusmayadi/domain/entities/message.dart';

class MessageModel extends Equatable {
  final int? status;
  final String? message;

  const MessageModel({
    this.status,
    this.message,
  });

  Message toEntity() => Message(status: status, message: message);

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };

  @override
  List<Object?> get props => [status, message];
}
