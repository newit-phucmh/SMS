import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms/core/repository/authentication_repository.dart';
import 'package:sms/core/utils/constant.dart';

class CheckInRepository{
  Future<String> checkIn(String courseId) async {
    final auth = AuthenticationRepository();
    var sharedPr =await SharedPreferences.getInstance();
    var token = sharedPr.getString('token');
    var userId =sharedPr.getString('userId');
    var url = Uri.parse('${Constants.server}/student/checkin');
    var requestHeaders = <String, String>{
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try{
      var response = await http.post(
          url,
          body: {'user_id': userId, 'course_id': courseId},
          headers: requestHeaders);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');


      if (response.statusCode!=200){
        await auth.logOut();
        return 'Check in failed';
      } else {
        dynamic bd = jsonDecode(response.body);
        return bd['message'] as String;
      }



    } catch (error){
      print('failed with error: $error');
      return error.toString();
    }
  }
}