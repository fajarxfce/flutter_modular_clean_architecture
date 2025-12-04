import 'package:main_presentation/src/di/di.config.dart';
import 'package:shared/shared.dart';

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: false,
)
void configureMainPresentationDependencies(GetIt getIt) => init(getIt);
