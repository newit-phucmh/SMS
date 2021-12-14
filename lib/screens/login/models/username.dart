import 'package:formz/formz.dart';

enum UsernameValidationError { empty }
final RegExp emailValidatorRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure('');
  const Username.dirty([String value = '']) : super.dirty(value);

  @override
  UsernameValidationError? validator(String? value) {
    return emailValidatorRegExp.hasMatch(value!) ? null : UsernameValidationError.empty;
  }
}
