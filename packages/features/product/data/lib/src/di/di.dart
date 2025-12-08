import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:network/network.dart';
import 'package:product_data/src/di/di.config.dart';
import 'package:product_data/src/source/product_api_client.dart';

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: false,
)
void configureProductDataDependencies(GetIt getIt) => init(getIt);

@module
abstract class ProductDataModule {
  @injectable
  ProductApiClient productApiClient(Dio dio) {
    return ProductApiClient(dio);
  }
}
