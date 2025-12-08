import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:network/network.dart';
import 'package:product_domain/product_domain.dart';

@injectable
class GetProductsUsecase {
  final ProductRepository _repository;
  GetProductsUsecase(this._repository);
  Future<Either<Failure, List<Product>>> call(GetProductRequest request) {
    return _repository.fetchProducts(request);
  }
}
