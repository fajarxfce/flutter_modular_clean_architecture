import 'package:app/src/di/di.config.dart';
import 'package:app/src/router/app_router.dart';
import 'package:get_it/get_it.dart';
import 'package:home_presentation/home.dart';
import 'package:injectable/injectable.dart';
import 'package:login_presentation/login.dart';
import 'package:network/network.dart';
import 'package:onboarding_presentation/di/injection.dart';
import 'package:profile_presentation/profile.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> configureDependencies() async {
  init(getIt);

  // Network module - call setup dari network package (Kotlin style!)
  setupNetworkModule(getIt);

  configureOnboardingDependencies(getIt);
  configureLoginDependencies(getIt);
  configureHomeDependencies(getIt);
  configureProfileDependencies(getIt);
}

@module
abstract class RegisterModule {
  @singleton
  GetIt get getIt => GetIt.instance;

  @singleton
  AppRouter get appRouter => AppRouter();
}
