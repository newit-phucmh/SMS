import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms/authentication/bloc/authentication_bloc.dart';
import 'package:sms/core/models/studdent_profile_model.dart';
import 'package:sms/core/repository/authentication_repository.dart';
import 'package:sms/core/utils/constant.dart';
import 'package:sms/core/utils/shared_prefs.dart';

class ProfileRepository {
  Future<UserInfoModel> getProfile() async {
    var sharedPr =await SharedPreferences.getInstance();
    var token = sharedPr.getString('token');
    var userId =sharedPr.getString('userId');
    print('userId: $userId');
    if (userId!=null){
      var url = Uri.parse('${Constants.server}/student/profile/$userId');
      var requestHeaders = <String, String>{
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      try {
        var response = await http.get(
            url,
            headers: requestHeaders
        );
        print('Response status: ${response.statusCode}');

        print('Response body: ${response.body}');
        if (response.statusCode!=200){
          return UserInfoModel(-1, '', '', '', '', '', '');
        }
        var resBody = response.body;
        var responseModel = UserInfoModel.fromJson(jsonDecode(resBody));
        return responseModel;
      } catch (error){
        print('debug $error');
        return UserInfoModel(-1, '', '', '', '', '', '');
      }
    } else {
      return UserInfoModel(-1, '', '', '', '', '', '');
    }
  }
}