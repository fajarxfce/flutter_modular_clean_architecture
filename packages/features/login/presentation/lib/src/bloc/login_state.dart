enum LoginStatus { initial, loading, success, failure }

class LoginUiState {
  final LoginStatus status;
  const LoginUiState(this.status);

  factory LoginUiState.initial() => const LoginUiState(LoginStatus.initial);

  LoginUiState copyWith({LoginStatus? status}) {
    return LoginUiState(status ?? this.status);
  }
}
