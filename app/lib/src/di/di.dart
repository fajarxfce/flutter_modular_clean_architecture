import 'package:app/src/di/di.config.dart';
import 'package:app/src/router/app_router.dart';
import 'package:database/database.dart';
import 'package:get_it/get_it.dart';
import 'package:home_presentation/home.dart';
import 'package:injectable/injectable.dart';
import 'package:login_data/data.dart';
import 'package:login_domain/domain.dart';
import 'package:login_presentation/login.dart';
import 'package:main_presentation/main_presentation.dart';
import 'package:network/network.dart';
import 'package:onboarding_presentation/di/injection.dart';
import 'package:product_data/product_data.dart';
import 'package:product_domain/product_domain.dart';
import 'package:product_presentation/product_presentation.dart';
import 'package:profile_presentation/profile.dart';
import 'package:splash_presentation/splash_presentation.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: false,
)
void configureDependencies() {
  init(getIt);

  // Database & Network - register first
  configureDatabaseDependencies(getIt);
  configureNetworkDependencies(getIt);

  // Features
  configureSplashDependencies(getIt);
  configureOnboardingDependencies(getIt);
  configureLoginDependencies(getIt);
  configureHomeDependencies(getIt);
  configureProfileDependencies(getIt);
  configureLoginDomainDependencies(getIt);
  configureLoginDataDependencies(getIt);
  configureMainPresentationDependencies(getIt);
  configureProductDomainDependencies(getIt);
  configureProductDataDependencies(getIt);
  configureProductPresentationDependencies(getIt);
}

@module
abstract class RegisterModule {
  @singleton
  GetIt get getIt => GetIt.instance;

  @singleton
  AppRouter get appRouter => AppRouter();
}
