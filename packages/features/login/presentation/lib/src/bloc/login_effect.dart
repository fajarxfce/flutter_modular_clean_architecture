/// Side effects (single-shot events) for Login feature.
///
/// These are one-time events that should NOT be part of state.
/// Use these for navigation, showing dialogs, snackbars, etc.
sealed class LoginEffect {
  const LoginEffect();
}

/// Show error dialog with message
class ShowErrorDialog extends LoginEffect {
  final String message;
  const ShowErrorDialog(this.message);
}

/// Show success snackbar
class ShowSuccessSnackbar extends LoginEffect {
  final String message;
  const ShowSuccessSnackbar(this.message);
}

/// Navigate to Register screen
class NavigateToRegister extends LoginEffect {
  const NavigateToRegister();
}

/// Navigate to Dashboard after successful login
class NavigateToDashboard extends LoginEffect {
  const NavigateToDashboard();
}
