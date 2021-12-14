import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sms/core/models/login_response_model.dart';
import 'package:sms/core/utils/constant.dart';


class LoginRepository{

  Future<LoginResponseModel> login(String username, String password) async {
    print('$username, $password');
    var url = Uri.parse('${Constants.server}/auth/login');
    var response = await http.post(
        url,
        body: {'email': username, 'password': password});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    var resBody = response.body;
    var responseModel = LoginResponseModel.fromJson(jsonDecode(resBody));
    return responseModel;
  }

  Future<http.Response> logout(String token) async {
    var url = Uri.parse('${Constants.server}/auth/logout');
    var requestHeaders = <String, String>{
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var response = await http.post(
        url,
        headers: requestHeaders);
    print('response body: $response');

    return response;
  }
}
