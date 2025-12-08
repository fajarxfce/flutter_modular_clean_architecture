// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDTO _$ProductDTOFromJson(Map<String, dynamic> json) => ProductDTO(
  id: (json['id'] as num).toInt(),
  sku: json['sku'] as String?,
  name: json['name'] as String?,
  price: (json['price'] as num?)?.toInt(),
  stock: (json['stock'] as num?)?.toInt(),
  description: json['description'] as String?,
  status: (json['status'] as num?)?.toInt(),
  media: (json['media'] as List<dynamic>?)
      ?.map((e) => MediaDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ProductDTOToJson(ProductDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sku': instance.sku,
      'name': instance.name,
      'price': instance.price,
      'stock': instance.stock,
      'description': instance.description,
      'status': instance.status,
      'media': instance.media,
    };

MediaDto _$MediaDtoFromJson(Map<String, dynamic> json) => MediaDto(
  id: (json['id'] as num).toInt(),
  modelType: json['model_type'] as String,
  modelId: (json['model_id'] as num).toInt(),
  uuid: json['uuid'] as String,
  collectionName: json['collection_name'] as String,
  name: json['name'] as String,
  fileName: json['file_name'] as String,
);

Map<String, dynamic> _$MediaDtoToJson(MediaDto instance) => <String, dynamic>{
  'id': instance.id,
  'model_type': instance.modelType,
  'model_id': instance.modelId,
  'uuid': instance.uuid,
  'collection_name': instance.collectionName,
  'name': instance.name,
  'file_name': instance.fileName,
};
