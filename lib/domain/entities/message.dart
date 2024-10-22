import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final int? status;
  final String? message;

  const Message({
    this.status,
    this.message,
  });

  @override
  List<Object?> get props => [status, message];
}
