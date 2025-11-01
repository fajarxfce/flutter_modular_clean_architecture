abstract class LoginEvent {
  const LoginEvent();
}

class OnNavigateToRegisterEvent extends LoginEvent {
  const OnNavigateToRegisterEvent();
}

class OnLoginSubmittedEvent extends LoginEvent {
  final String email;
  final String password;

  const OnLoginSubmittedEvent({required this.email, required this.password});
}
