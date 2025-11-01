/// UI State for Login feature.
///
/// State represents the current UI representation, NOT one-time events.
/// For one-time events (navigation, dialogs, etc), use [LoginEffect].
enum LoginStatus {
  /// Initial state, showing login form
  initial,

  /// Loading state, showing progress indicator
  loading,

  /// Success state, user data loaded (but navigation is handled by Effect)
  success,
}

class LoginUiState {
  final LoginStatus status;
  final String email;

  const LoginUiState({required this.status, this.email = ''});

  factory LoginUiState.initial() =>
      const LoginUiState(status: LoginStatus.initial);

  LoginUiState copyWith({LoginStatus? status, String? email}) {
    return LoginUiState(
      status: status ?? this.status,
      email: email ?? this.email,
    );
  }
}
