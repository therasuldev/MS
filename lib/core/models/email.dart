import 'package:formz/formz.dart';

enum UsernameValidationError { empty }

class Email extends FormzInput<String, UsernameValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([String value = '']) : super.dirty(value);

  @override
  UsernameValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : UsernameValidationError.empty;
  }
}