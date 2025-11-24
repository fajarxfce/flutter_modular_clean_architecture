import 'package:widgets/src/form/base_form_input.dart';

/// Password input using BaseTextInput
class PasswordInput extends BaseTextInput {
  const PasswordInput.pure() : super.pure();
  const PasswordInput.dirty([super.value = '']) : super.dirty();

  @override
  int get minLength => 6;

  @override
  String get fieldName => 'Password';

  @override
  String? get errorMessage {
    if (displayError == null) return null;
    switch (displayError!) {
      case ValidationError.empty:
        return 'Password is required';
      case ValidationError.tooShort:
        return 'Password must be at least $minLength characters';
      default:
        return displayError!.message(fieldName);
    }
  }
}
