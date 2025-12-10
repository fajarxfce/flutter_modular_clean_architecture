import 'package:analytics/src/di/di.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@InjectableInit(
  initializerName: 'initAnalytics',
  preferRelativeImports: true,
  asExtension: true,
)
void configureAnalyticsDependencies(GetIt getIt) => getIt.initAnalytics();
