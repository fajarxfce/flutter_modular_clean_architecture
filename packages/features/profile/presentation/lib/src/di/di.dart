import 'package:profile_presentation/src/di/di.config.dart';
import 'package:shared/shared.dart';

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: false,
)
void configureProfileDependencies(GetIt getIt) => init(getIt);
