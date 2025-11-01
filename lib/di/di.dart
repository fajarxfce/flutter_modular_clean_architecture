import 'package:flutter_modular_clean_architecture/di/di.config.dart';
import 'package:flutter_modular_clean_architecture/router/app_router.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:login_presentation/login.dart';
import 'package:onboarding_presentation/di/injection.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> configureDependencies() async {
  init(getIt);
  configureOnboardingDependencies(getIt);
  configureLoginDependencies(getIt);
}

@module
abstract class RegisterModule {
  @singleton
  GetIt get getIt => GetIt.instance;

  @singleton
  AppRouter get appRouter => AppRouter();
}
