import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:network/src/config/network_config.dart';
import 'package:network/src/di/network_module.dart';

void setupNetworkModule(GetIt getIt) {
  final networkModule = _NetworkModuleImpl();

  getIt.registerLazySingleton<NetworkConfig>(() => networkModule.networkConfig);

  getIt.registerLazySingleton<Dio>(
    () => networkModule.dio(getIt<NetworkConfig>()),
  );
}

class _NetworkModuleImpl extends NetworkModule {}
