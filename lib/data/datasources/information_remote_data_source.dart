import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sims_ppob_roni_rusmayadi/common/constants.dart';
import 'package:sims_ppob_roni_rusmayadi/common/exception.dart';
import 'package:sims_ppob_roni_rusmayadi/data/models/informations/banner_response_model.dart';
import 'package:sims_ppob_roni_rusmayadi/data/models/informations/services_response_model.dart';
import 'package:http/http.dart' as http;

abstract class InformationRemoteDataSource {
  Future<BannerResponseModel> getBanner();
  Future<ServicesResponseModel> getServices();
}

class InformationRemoteDataSourceImpl extends InformationRemoteDataSource {
  final http.Client client;

  InformationRemoteDataSourceImpl({required this.client});

  @override
  Future<BannerResponseModel> getBanner() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final response = await client.get(Uri.parse('$baseUrl/banner'),
        headers: {"Authorization": 'Bearer $token'});

    if (response.statusCode == 200) {
      return BannerResponseModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException(json.decode(response.body)['message'] ?? "");
    }
  }

  @override
  Future<ServicesResponseModel> getServices() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final response = await client.get(Uri.parse('$baseUrl/services'),
        headers: {"Authorization": 'Bearer $token'});

    if (response.statusCode == 200) {
      return ServicesResponseModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException(json.decode(response.body)['message'] ?? "");
    }
  }
}
