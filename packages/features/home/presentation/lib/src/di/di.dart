import 'package:home_presentation/src/di/di.config.dart';
import 'package:shared/shared.dart';

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: false,
)
void configureHomeDependencies(GetIt getIt) => init(getIt);
