import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:network/src/di/di.config.dart';

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: false,
)
void configureNetworkDependencies(GetIt getIt) => init(getIt);
