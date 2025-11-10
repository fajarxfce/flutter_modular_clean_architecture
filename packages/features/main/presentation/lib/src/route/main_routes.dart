final class MainRoutes {
  static MainRoutes? _instance;
  factory MainRoutes() => _instance ??= MainRoutes._();

  MainRoutes._();
  String get login => '/main';
}
