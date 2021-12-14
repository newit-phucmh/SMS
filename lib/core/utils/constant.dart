
import 'dart:ui';

abstract class Constants{
  //server
  static final String server='http://10.0.2.2:8000/api';

  static const cSecondTextColor = Color(0xFF9d9d9d);
  static const cPlashColor = Color(0xffd9cdcd);
  static const kPrimaryColor = Color(0xFFFF7643);
  static const kTextColor = Color(0xFF757575);

  final RegExp emailValidatorRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
  static const String kEmailNullError = 'Please Enter your email';
  static const String kInvalidEmailError = 'Please Enter Valid Email';
  static const String kPassNullError = 'Please Enter your password';
  static const String kShortPassError = 'Password is too short';

}