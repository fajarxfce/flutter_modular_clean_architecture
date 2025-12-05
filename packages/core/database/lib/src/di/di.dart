import 'package:database/src/di/di.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@InjectableInit(
  initializerName: 'initDatabase',
  preferRelativeImports: true,
  asExtension: true,
)
void configureDatabaseDependencies(GetIt getIt) => getIt.initDatabase();
