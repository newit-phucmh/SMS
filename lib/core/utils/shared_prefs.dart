import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms/core/models/studdent_profile_model.dart';

abstract class SharedPreferencesHelper {
  Future<String> getLastToken();
  Future<void> cacheStudentProfile(UserInfoModel studentProfileModel);
  Future<UserInfoModel> getCacheStudentProfile();
}

class SharedPreferencesHelperIml extends SharedPreferencesHelper{
  SharedPreferencesHelperIml(this.sharedPreferences);
  final SharedPreferences sharedPreferences;
  @override
  Future<UserInfoModel> getCacheStudentProfile() {
    var jsonStr = sharedPreferences.getString('student_profile');
    if (jsonStr == null) {
      return Future.value(UserInfoModel(-1,'','','','','',''));
    }
    return Future.value(UserInfoModel.fromJson(jsonDecode(jsonStr)));
  }

  @override
  Future<String> getLastToken(){
    var token = sharedPreferences.getString('token');
    if (token==null){
      return Future.value('');
    } else {
      return Future.value(token);
    }
  }

  @override
  Future<void> cacheStudentProfile(UserInfoModel studentProfileModel) {
    return sharedPreferences.setString(
        'student_profile',
        jsonEncode(studentProfileModel));
  }

}