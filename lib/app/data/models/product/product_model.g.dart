// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      imageUrl: json['imageUrl'],
      videoUrl: json['videoUrl'],
      isInStock: json['isInStock'] as bool?,
      description: json['description'] as String?,
      pdfUrl: json['pdfUrl'] as String?,
      price: json['price'] as String?,
      shortDescription: json['shortDescription'] as String?,
      createdAt: _$JsonConverterFromJson<String, DateTime>(
          json['createdAt'], const CustomDateTimeConverter().fromJson),
      updatedAt: _$JsonConverterFromJson<String, DateTime>(
          json['updatedAt'], const CustomDateTimeConverter().fromJson),
      productCheckout: json['productCheckout'] == null
          ? null
          : ProductCheckoutModel.fromJson(
              json['productCheckout'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'videoUrl': instance.videoUrl,
      'isInStock': instance.isInStock,
      'description': instance.description,
      'pdfUrl': instance.pdfUrl,
      'price': instance.price,
      'shortDescription': instance.shortDescription,
      'createdAt': _$JsonConverterToJson<String, DateTime>(
          instance.createdAt, const CustomDateTimeConverter().toJson),
      'updatedAt': _$JsonConverterToJson<String, DateTime>(
          instance.updatedAt, const CustomDateTimeConverter().toJson),
      'productCheckout': instance.productCheckout?.toJson(),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
