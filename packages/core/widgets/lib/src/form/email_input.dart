import 'package:widgets/src/form/base_form_input.dart';

/// Email input using BasePatternInput
class EmailInput extends BasePatternInput {
  const EmailInput.pure() : super.pure();
  const EmailInput.dirty([super.value = '']) : super.dirty();

  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  @override
  RegExp get pattern => _emailRegex;

  @override
  String get fieldName => 'Email';

  @override
  String get invalidMessage => 'Please enter a valid email';
}
