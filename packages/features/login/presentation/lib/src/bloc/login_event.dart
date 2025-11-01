abstract class LoginEvent {
  const LoginEvent();
}

class OnNavigateToRegisterEvent extends LoginEvent {
  const OnNavigateToRegisterEvent();
}

class OnEmailChangedEvent extends LoginEvent {
  final String email;

  const OnEmailChangedEvent(this.email);
}

class OnPasswordChangedEvent extends LoginEvent {
  final String password;

  const OnPasswordChangedEvent(this.password);
}

class OnLoginSubmittedEvent extends LoginEvent {
  const OnLoginSubmittedEvent();
}
