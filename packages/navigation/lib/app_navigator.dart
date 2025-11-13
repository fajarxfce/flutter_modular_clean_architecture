abstract class AppNavigator {
  Future<void> navigateToOnboarding();
  Future<void> navigateToHome();
  Future<void> navigateToLogin(String? hello);
  Future<void> navigateToMain();
  Future<void> navigateToRegister();
  Future<void> navigateToProfile();

  void navigateBack<T>([T? result]);

  Future<T?> navigateToRegisterForResult<T>();
  Future<T?> navigateToAddProduct<T>();
}
