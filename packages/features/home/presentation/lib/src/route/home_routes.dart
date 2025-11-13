final class HomeRoutes {
  static HomeRoutes? _instance;
  factory HomeRoutes() => _instance ??= HomeRoutes._();

  HomeRoutes._();
  String get login => '/home';
}
