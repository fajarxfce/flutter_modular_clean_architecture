import 'package:formz/formz.dart';
import 'package:shared/shared.dart';
import 'package:widgets/formz.dart';

enum LoginStatus { initial, loading, success }

class LoginUiState extends BaseState {
  final LoginStatus status;
  final EmailInput email;
  final PasswordInput password;

  const LoginUiState({
    required this.status,
    this.email = const EmailInput.pure(),
    this.password = const PasswordInput.pure(),
  });

  factory LoginUiState.initial() =>
      const LoginUiState(status: LoginStatus.initial);

  bool get isFormValid => Formz.validate([email, password]);

  LoginUiState copyWith({
    LoginStatus? status,
    EmailInput? email,
    PasswordInput? password,
  }) {
    return LoginUiState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [status, email, password];
}
