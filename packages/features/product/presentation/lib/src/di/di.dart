import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:product_presentation/src/di/di.config.dart';

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: false,
)
void configureProductPresentationDependencies(GetIt getIt) => init(getIt);
