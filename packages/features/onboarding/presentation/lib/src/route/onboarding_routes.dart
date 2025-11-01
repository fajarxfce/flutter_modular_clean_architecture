final class OnboardingRoutes {
  static OnboardingRoutes? _instance;
  factory OnboardingRoutes() => _instance ??= OnboardingRoutes._();

  OnboardingRoutes._();
  String get onBoarding => '/onboarding';
}
