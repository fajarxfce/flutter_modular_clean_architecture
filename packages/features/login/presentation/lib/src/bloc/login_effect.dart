import 'package:shared/shared.dart';

sealed class LoginEffect extends BaseEffect {
  const LoginEffect();
}

class ShowErrorDialog extends LoginEffect {
  final String message;
  const ShowErrorDialog(this.message);
}

class ShowSuccessSnackbar extends LoginEffect {
  final String message;
  const ShowSuccessSnackbar(this.message);
}

class NavigateToRegister extends LoginEffect {
  const NavigateToRegister();
}

class NavigateToDashboard extends LoginEffect {
  const NavigateToDashboard();
}

class PlaySound extends LoginEffect {
  const PlaySound();
}
