import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:splash_presentation/src/di/injection.config.dart';

@InjectableInit(
  initializerName: 'initSplash',
  preferRelativeImports: true,
  asExtension: true,
)
void configureSplashDependencies(GetIt getIt) => getIt.initSplash();
