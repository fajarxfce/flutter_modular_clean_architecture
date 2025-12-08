import 'package:dartz/dartz.dart';
import 'package:network/network.dart';
import 'package:product_domain/product_domain.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> fetchProducts(
    GetProductRequest request,
  );
}
