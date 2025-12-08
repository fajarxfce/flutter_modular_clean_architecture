import 'package:product_data/src/source/remote/response/product_dto.dart';
import 'package:product_domain/product_domain.dart';

extension ProductMapper on ProductDTO {
  Product toDomain() {
    return Product(
      id: id,
      name: name,
      description: description,
      price: price,
      stock: stock,
      imageUrls: media?.map((e) => e.fileName).toList() ?? [],
    );
  }
}

extension ProductListMapper on List<ProductDTO> {
  List<Product> toDomainList() {
    return map((dto) => dto.toDomain()).toList();
  }
}
