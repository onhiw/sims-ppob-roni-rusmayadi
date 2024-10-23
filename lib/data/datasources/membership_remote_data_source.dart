import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sims_ppob_roni_rusmayadi/common/constants.dart';
import 'package:sims_ppob_roni_rusmayadi/common/exception.dart';
import 'package:sims_ppob_roni_rusmayadi/data/models/memberships/login_response_model.dart';
import 'package:sims_ppob_roni_rusmayadi/data/models/memberships/user_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:sims_ppob_roni_rusmayadi/data/models/message_model.dart';

abstract class MembershipRemoteDataSource {
  Future<UserResponseModel> getProfile();
  Future<LoginResponseModel> postLogin(String email, String password);
  Future<MessageModel> postRegister(
      String email, String firstname, String lastname, String password);
  Future<UserResponseModel> putProfile(String firstname, String lastname);
  Future<UserResponseModel> putProfileImage(File image);
}

class MembershipRemoteDataSourceImpl extends MembershipRemoteDataSource {
  final http.Client client;

  MembershipRemoteDataSourceImpl({required this.client});

  @override
  Future<UserResponseModel> getProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final response = await client.get(Uri.parse('$baseUrl/profile'),
        headers: {"Authorization": 'Bearer $token'});

    if (response.statusCode == 200) {
      return UserResponseModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException(json.decode(response.body)['message'] ?? "");
    }
  }

  @override
  Future<LoginResponseModel> postLogin(String email, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await client.post(Uri.parse('$baseUrl/login'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}));

    if (response.statusCode == 200) {
      await prefs.setString(
          'token', json.decode(response.body)['data']['token']);
      return LoginResponseModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException(json.decode(response.body)['message'] ?? "");
    }
  }

  @override
  Future<MessageModel> postRegister(
      String email, String firstname, String lastname, String password) async {
    final response = await client.post(Uri.parse('$baseUrl/register'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "first_name": firstname,
          "last_name": lastname,
          "password": password
        }));

    if (response.statusCode == 200) {
      return MessageModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException(json.decode(response.body)['message'] ?? "");
    }
  }

  @override
  Future<UserResponseModel> putProfile(
      String firstname, String lastname) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final response = await client.put(Uri.parse('$baseUrl/profile/update'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: jsonEncode({"first_name": firstname, "last_name": lastname}));

    if (response.statusCode == 200) {
      return UserResponseModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException(json.decode(response.body)['message'] ?? "");
    }
  }

  @override
  Future<UserResponseModel> putProfileImage(File image) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final request = MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/media/upload'),
    );

    Map<String, String> headers = {
      "Content-type": "multipart/form-data",
      "Authorization": "Bearer $token"
    };

    request.files.add(await MultipartFile.fromPath(
      'file',
      image.path,
      filename: image.path,
    ));

    request.headers.addAll(headers);

    final response = await request.send();
    final resString = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      return UserResponseModel.fromJson(json.decode(resString));
    } else {
      throw ServerException(json.decode(resString)['message'] ?? "");
    }
  }
}
