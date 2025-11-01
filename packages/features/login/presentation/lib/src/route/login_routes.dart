final class LoginRoutes {
  static LoginRoutes? _instance;
  factory LoginRoutes() => _instance ??= LoginRoutes._();

  LoginRoutes._();
  String get login => '/login';
}
