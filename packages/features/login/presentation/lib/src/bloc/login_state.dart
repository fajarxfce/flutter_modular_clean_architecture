import 'package:shared/shared.dart';

enum LoginStatus { initial, loading, success }

class LoginUiState extends BaseState {
  final LoginStatus status;
  final String email;
  final String password;

  const LoginUiState({
    required this.status,
    this.email = '',
    this.password = '',
  });

  factory LoginUiState.initial() =>
      const LoginUiState(status: LoginStatus.initial);

  bool get isEmailEmpty => email.isEmpty;

  bool get isPasswordEmpty => password.isEmpty;

  bool get isFormValid => email.isNotEmpty && password.isNotEmpty;

  LoginUiState copyWith({
    LoginStatus? status,
    String? email,
    String? password,
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
