import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:network/network.dart';
import 'package:product_data/src/mapper/product_mapper.dart';
import 'package:product_data/src/source/remote/product_remote_datasource.dart';
import 'package:product_domain/product_domain.dart';

@Injectable(as: ProductRepository)
class ProductRepositoryImpl extends ProductRepository {
  final ProductRemoteDatasource _remoteDatasource;
  ProductRepositoryImpl(this._remoteDatasource);

  @override
  Future<Either<Failure, List<Product>>> fetchProducts(
    GetProductRequest request,
  ) {
    return SafeApiCall.execute(() async {
      final productDtos = await _remoteDatasource.fetchProducts(request);
      return productDtos.toDomainList();
    });
  }
}
