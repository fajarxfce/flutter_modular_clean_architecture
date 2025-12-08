import 'package:injectable/injectable.dart';
import 'package:product_data/src/source/product_api_client.dart';
import 'package:product_data/src/source/remote/response/product_dto.dart';
import 'package:product_domain/product_domain.dart';

abstract class ProductRemoteDatasource {
  Future<List<ProductDTO>> fetchProducts(GetProductRequest params);
}

@Injectable(as: ProductRemoteDatasource)
class ProductRemoteDatasourceImpl implements ProductRemoteDatasource {
  final ProductApiClient _apiClient;

  ProductRemoteDatasourceImpl(this._apiClient);

  @override
  Future<List<ProductDTO>> fetchProducts(GetProductRequest params) async {
    return await _apiClient.fetchProducts(params.toQueryParameters());
  }
}
