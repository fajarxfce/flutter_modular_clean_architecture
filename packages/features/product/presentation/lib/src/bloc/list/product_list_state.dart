import 'package:product_domain/product_domain.dart';
import 'package:shared/shared.dart';

enum ProductListStatus { initial, loading, success, failure }

class ProductListState extends BaseState {
  final ProductListStatus status;
  final List<Product>? products;

  const ProductListState({required this.status, this.products});

  factory ProductListState.initial() =>
      const ProductListState(status: ProductListStatus.initial);
  ProductListState copyWith({
    ProductListStatus? status,
    List<Product>? products,
  }) {
    return ProductListState(
      status: status ?? this.status,
      products: products ?? this.products,
    );
  }
}
