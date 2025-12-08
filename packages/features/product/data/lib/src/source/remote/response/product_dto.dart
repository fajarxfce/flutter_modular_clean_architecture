import 'package:json_annotation/json_annotation.dart';

part 'product_dto.g.dart';

@JsonSerializable()
class ProductDTO {
  final int id;
  final String? sku;
  final String? name;
  final int? price;
  final int? stock;
  final String? description;
  final int? status;
  final List<MediaDto>? media;

  ProductDTO({
    required this.id,
    required this.sku,
    required this.name,
    required this.price,
    required this.stock,
    required this.description,
    required this.status,
    this.media,
  });

  factory ProductDTO.fromJson(Map<String, dynamic> json) =>
      _$ProductDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDTOToJson(this);
}

@JsonSerializable()
class MediaDto {
  final int id;
  @JsonKey(name: 'model_type')
  final String modelType;
  @JsonKey(name: 'model_id')
  final int modelId;
  final String uuid;
  @JsonKey(name: 'collection_name')
  final String collectionName;
  final String name;
  @JsonKey(name: 'file_name')
  final String fileName;

  MediaDto({
    required this.id,
    required this.modelType,
    required this.modelId,
    required this.uuid,
    required this.collectionName,
    required this.name,
    required this.fileName,
  });

  factory MediaDto.fromJson(Map<String, dynamic> json) =>
      _$MediaDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MediaDtoToJson(this);
}
