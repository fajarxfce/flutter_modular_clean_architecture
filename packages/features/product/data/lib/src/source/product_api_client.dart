import 'package:dio/dio.dart';
import 'package:product_data/src/source/remote/response/product_dto.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'product_api_client.g.dart';

@RestApi()
abstract class ProductApiClient {
  factory ProductApiClient(Dio dio, {String? baseUrl}) = _ProductApiClient;

  @GET('/product')
  Future<List<ProductDTO>> fetchProducts(
    @Queries() Map<String, dynamic> queries,
  );
}
