import 'package:widgets/src/form/base_form_input.dart';

/// Phone number input
class PhoneInput extends BasePatternInput {
  const PhoneInput.pure() : super.pure();
  const PhoneInput.dirty([super.value = '']) : super.dirty();

  static final _phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');

  @override
  RegExp get pattern => _phoneRegex;

  @override
  String get fieldName => 'Phone';

  @override
  String get invalidMessage => 'Please enter a valid phone number';
}

/// Username input (3-20 chars, alphanumeric + underscore)
class UsernameInput extends BasePatternInput {
  const UsernameInput.pure() : super.pure();
  const UsernameInput.dirty([super.value = '']) : super.dirty();

  static final _usernameRegex = RegExp(r'^[a-zA-Z0-9_]{3,20}$');

  @override
  RegExp get pattern => _usernameRegex;

  @override
  String get fieldName => 'Username';

  @override
  String get invalidMessage =>
      'Username must be 3-20 characters (letters, numbers, underscore only)';
}

/// URL input
class UrlInput extends BasePatternInput {
  const UrlInput.pure() : super.pure();
  const UrlInput.dirty([super.value = '']) : super.dirty();

  static final _urlRegex = RegExp(
    r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
  );

  @override
  RegExp get pattern => _urlRegex;

  @override
  String get fieldName => 'URL';

  @override
  String get invalidMessage => 'Please enter a valid URL';
}

/// Name input (2-50 chars)
class NameInput extends BaseTextInput {
  const NameInput.pure() : super.pure();
  const NameInput.dirty([super.value = '']) : super.dirty();

  @override
  int get minLength => 2;

  @override
  int get maxLength => 50;

  @override
  String get fieldName => 'Name';
}

/// Full name input (supports space for first and last name)
class FullNameInput extends BaseTextInput {
  const FullNameInput.pure() : super.pure();
  const FullNameInput.dirty([super.value = '']) : super.dirty();

  @override
  int get minLength => 3;

  @override
  int get maxLength => 100;

  @override
  String get fieldName => 'Full Name';
}

/// Age input (numeric with range)
class AgeInput extends BaseNumberInput {
  const AgeInput.pure() : super.pure();
  const AgeInput.dirty([super.value = '']) : super.dirty();

  @override
  num get min => 1;

  @override
  num get max => 150;

  @override
  String get fieldName => 'Age';
}

/// Price input (decimal allowed)
class PriceInput extends BaseNumberInput {
  const PriceInput.pure() : super.pure();
  const PriceInput.dirty([super.value = '']) : super.dirty();

  @override
  num get min => 0;

  @override
  String get fieldName => 'Price';

  @override
  String? get errorMessage {
    if (displayError == ValidationError.tooShort) {
      return 'Price must be greater than or equal to 0';
    }
    return super.errorMessage;
  }
}

/// Confirm password input
class ConfirmPasswordInput extends BaseConfirmationInput {
  const ConfirmPasswordInput.pure({super.originalValue}) : super.pure();
  const ConfirmPasswordInput.dirty(super.value, {super.originalValue})
    : super.dirty();

  @override
  String get fieldName => 'password';

  @override
  String get mismatchMessage => 'Passwords do not match';
}

/// Bio/Description input (optional, with max length)
class BioInput extends BaseTextInput {
  const BioInput.pure() : super.pure();
  const BioInput.dirty([super.value = '']) : super.dirty();

  @override
  bool get isRequired => false;

  @override
  int get maxLength => 500;

  @override
  String get fieldName => 'Bio';
}

/// ZIP/Postal code input
class ZipCodeInput extends BasePatternInput {
  const ZipCodeInput.pure() : super.pure();
  const ZipCodeInput.dirty([super.value = '']) : super.dirty();

  // Supports various formats: 12345, 12345-6789, A1A 1A1, etc
  static final _zipRegex = RegExp(r'^[0-9A-Za-z\s-]{3,10}$');

  @override
  RegExp get pattern => _zipRegex;

  @override
  String get fieldName => 'ZIP Code';

  @override
  String get invalidMessage => 'Please enter a valid ZIP code';
}

/// Credit card number input
class CreditCardInput extends BasePatternInput {
  const CreditCardInput.pure() : super.pure();
  const CreditCardInput.dirty([super.value = '']) : super.dirty();

  // Basic pattern: 13-19 digits (can include spaces/dashes)
  static final _cardRegex = RegExp(r'^[\d\s-]{13,19}$');

  @override
  RegExp get pattern => _cardRegex;

  @override
  String get fieldName => 'Credit Card';

  @override
  String get invalidMessage => 'Please enter a valid credit card number';
}
