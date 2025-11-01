final class RegisterRoutes {
  static RegisterRoutes? _instance;
  factory RegisterRoutes() => _instance ??= RegisterRoutes._();

  RegisterRoutes._();
  String get register => '/register';
}
