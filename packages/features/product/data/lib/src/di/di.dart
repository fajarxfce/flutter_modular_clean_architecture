import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:product_data/src/di/di.config.dart';

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: false,
)
void configureProductDataDependencies(GetIt getIt) => init(getIt);
