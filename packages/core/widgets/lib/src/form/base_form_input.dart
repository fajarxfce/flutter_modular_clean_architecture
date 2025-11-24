// Base form input for universal form validation
// Extend these classes to create custom form inputs with common validation
import 'package:formz/formz.dart';

/// Common validation errors
enum ValidationError { empty, tooShort, tooLong, invalid }

/// Extension to get error messages
extension ValidationErrorX on ValidationError {
  String message([String? fieldName]) {
    final field = fieldName ?? 'Field';
    switch (this) {
      case ValidationError.empty:
        return '$field is required';
      case ValidationError.tooShort:
        return '$field is too short';
      case ValidationError.tooLong:
        return '$field is too long';
      case ValidationError.invalid:
        return '$field is invalid';
    }
  }
}

/// Base class for text inputs with common validations
///
/// Extend this class to create custom inputs:
/// ```dart
/// class NameInput extends BaseTextInput {
///   const NameInput.pure() : super.pure();
///   const NameInput.dirty([super.value = '']) : super.dirty();
///
///   @override
///   int? get minLength => 2;
///
///   @override
///   int? get maxLength => 50;
///
///   @override
///   String get fieldName => 'Name';
/// }
/// ```
abstract class BaseTextInput extends FormzInput<String, ValidationError> {
  const BaseTextInput.pure() : super.pure('');
  const BaseTextInput.dirty([super.value = '']) : super.dirty();

  /// Whether this field is required (default: true)
  bool get isRequired => true;

  /// Minimum length for the input (optional)
  int? get minLength => null;

  /// Maximum length for the input (optional)
  int? get maxLength => null;

  /// Field name for error messages
  String get fieldName => 'Field';

  @override
  ValidationError? validator(String value) {
    if (isRequired && value.isEmpty) {
      return ValidationError.empty;
    }
    if (minLength != null && value.length < minLength!) {
      return ValidationError.tooShort;
    }
    if (maxLength != null && value.length > maxLength!) {
      return ValidationError.tooLong;
    }
    return customValidator(value);
  }

  /// Override this for custom validation logic
  ValidationError? customValidator(String value) => null;

  String? get errorMessage => displayError?.message(fieldName);
}

/// Base class for inputs with regex pattern validation
///
/// Extend this class for pattern-based validation:
/// ```dart
/// class PhoneInput extends BasePatternInput {
///   const PhoneInput.pure() : super.pure();
///   const PhoneInput.dirty([super.value = '']) : super.dirty();
///
///   @override
///   RegExp get pattern => RegExp(r'^\+?[0-9]{10,15}$');
///
///   @override
///   String get fieldName => 'Phone';
///
///   @override
///   String get invalidMessage => 'Please enter a valid phone number';
/// }
/// ```
abstract class BasePatternInput extends FormzInput<String, ValidationError> {
  const BasePatternInput.pure() : super.pure('');
  const BasePatternInput.dirty([super.value = '']) : super.dirty();

  /// Whether this field is required (default: true)
  bool get isRequired => true;

  /// Regex pattern for validation
  RegExp get pattern;

  /// Field name for error messages
  String get fieldName => 'Field';

  /// Custom message for invalid pattern
  String get invalidMessage => '$fieldName is invalid';

  @override
  ValidationError? validator(String value) {
    if (isRequired && value.isEmpty) {
      return ValidationError.empty;
    }
    if (value.isNotEmpty && !pattern.hasMatch(value)) {
      return ValidationError.invalid;
    }
    return null;
  }

  String? get errorMessage {
    if (displayError == null) return null;
    switch (displayError!) {
      case ValidationError.empty:
        return '$fieldName is required';
      case ValidationError.invalid:
        return invalidMessage;
      default:
        return displayError!.message(fieldName);
    }
  }
}

/// Base class for number inputs with range validation
///
/// Extend this class for numeric validation:
/// ```dart
/// class AgeInput extends BaseNumberInput {
///   const AgeInput.pure() : super.pure();
///   const AgeInput.dirty([super.value = '']) : super.dirty();
///
///   @override
///   num? get min => 18;
///
///   @override
///   num? get max => 100;
///
///   @override
///   String get fieldName => 'Age';
/// }
/// ```
abstract class BaseNumberInput extends FormzInput<String, ValidationError> {
  const BaseNumberInput.pure() : super.pure('');
  const BaseNumberInput.dirty([super.value = '']) : super.dirty();

  /// Whether this field is required (default: true)
  bool get isRequired => true;

  /// Minimum value
  num? get min => null;

  /// Maximum value
  num? get max => null;

  /// Field name for error messages
  String get fieldName => 'Number';

  @override
  ValidationError? validator(String value) {
    if (isRequired && value.isEmpty) {
      return ValidationError.empty;
    }

    if (value.isEmpty && !isRequired) return null;

    final number = num.tryParse(value);
    if (number == null) return ValidationError.invalid;

    if (min != null && number < min!) return ValidationError.tooShort;
    if (max != null && number > max!) return ValidationError.tooLong;

    return null;
  }

  String? get errorMessage {
    if (displayError == null) return null;
    switch (displayError!) {
      case ValidationError.empty:
        return '$fieldName is required';
      case ValidationError.invalid:
        return 'Please enter a valid number';
      case ValidationError.tooShort:
        return '$fieldName must be at least $min';
      case ValidationError.tooLong:
        return '$fieldName must be at most $max';
    }
  }
}

/// Base class for password confirmation inputs
///
/// Extend this class for password matching:
/// ```dart
/// class ConfirmPasswordInput extends BaseConfirmationInput {
///   const ConfirmPasswordInput.pure({super.originalValue}) : super.pure();
///   const ConfirmPasswordInput.dirty(super.value, {super.originalValue}) : super.dirty();
///
///   @override
///   String get fieldName => 'Confirm Password';
///
///   @override
///   String get mismatchMessage => 'Passwords do not match';
/// }
/// ```
abstract class BaseConfirmationInput
    extends FormzInput<String, ValidationError> {
  final String originalValue;

  const BaseConfirmationInput.pure({this.originalValue = ''}) : super.pure('');
  const BaseConfirmationInput.dirty(super.value, {this.originalValue = ''})
    : super.dirty();

  /// Field name for error messages
  String get fieldName => 'Confirmation';

  /// Custom message when values don't match
  String get mismatchMessage => 'Values do not match';

  @override
  ValidationError? validator(String value) {
    if (value.isEmpty) return ValidationError.empty;
    if (value != originalValue) return ValidationError.invalid;
    return null;
  }

  String? get errorMessage {
    if (displayError == null) return null;
    switch (displayError!) {
      case ValidationError.empty:
        return 'Please confirm your $fieldName';
      case ValidationError.invalid:
        return mismatchMessage;
      default:
        return displayError!.message(fieldName);
    }
  }
}
