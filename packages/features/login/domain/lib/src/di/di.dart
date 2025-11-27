import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:login_domain/src/di/di.config.dart';

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: false,
)
void configureLoginDomainDependencies(GetIt getIt) => init(getIt);
