import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sims_ppob_roni_rusmayadi/common/constants.dart';
import 'package:sims_ppob_roni_rusmayadi/common/exception.dart';
import 'package:sims_ppob_roni_rusmayadi/data/models/message_model.dart';
import 'package:sims_ppob_roni_rusmayadi/data/models/transactions/balance_response_model.dart';
import 'package:sims_ppob_roni_rusmayadi/data/models/transactions/history_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:sims_ppob_roni_rusmayadi/data/models/transactions/transaction_detail_response_model.dart';

abstract class TransactionRemoteDataSource {
  Future<BalanceResponseModel> getBalance();
  Future<HistoryResponeModel> getHistory(int offset, int limit);
  Future<MessageModel> postTopUp(int amount);
  Future<TransactionDetailResponseModel> postTransaction(String serviceCode);
}

class TransactionRemoteDataSourceImpl extends TransactionRemoteDataSource {
  final http.Client client;

  TransactionRemoteDataSourceImpl({required this.client});

  @override
  Future<BalanceResponseModel> getBalance() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final response = await client.get(Uri.parse('$baseUrl/balance'),
        headers: {"Authorization": 'Bearer $token'});

    if (response.statusCode == 200) {
      return BalanceResponseModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException(json.decode(response.body)['message'] ?? "");
    }
  }

  @override
  Future<HistoryResponeModel> getHistory(int offset, int limit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final response = await client.get(Uri.parse('$baseUrl/transaction/history'),
        headers: {"Authorization": 'Bearer $token'});

    if (response.statusCode == 200) {
      return HistoryResponeModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException(json.decode(response.body)['message'] ?? "");
    }
  }

  @override
  Future<MessageModel> postTopUp(int amount) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final response = await client.post(Uri.parse('$baseUrl/topup'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: jsonEncode({"top_up_amount": amount}));

    if (response.statusCode == 200) {
      return MessageModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException(json.decode(response.body)['message'] ?? "");
    }
  }

  @override
  Future<TransactionDetailResponseModel> postTransaction(
      String serviceCode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final response = await client.post(Uri.parse('$baseUrl/transaction'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: jsonEncode({"service_code": serviceCode}));

    if (response.statusCode == 200) {
      return TransactionDetailResponseModel.fromJson(
          json.decode(response.body));
    } else {
      throw ServerException(json.decode(response.body)['message'] ?? "");
    }
  }
}
