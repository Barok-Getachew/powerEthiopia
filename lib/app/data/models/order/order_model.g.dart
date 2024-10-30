// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      id: json['id'] as int?,
      totalPrice: json['totalPrice'] as String?,
      paymentId: json['paymentId'] as String?,
      paymentImageUrl: json['paymentImageUrl'] as String?,
      deliveryAddressId: json['deliveryAddressId'] as int?,
      createdAt: _$JsonConverterFromJson<String, DateTime>(
          json['createdAt'], const CustomDateTimeConverter().fromJson),
      updatedAt: _$JsonConverterFromJson<String, DateTime>(
          json['updatedAt'], const CustomDateTimeConverter().fromJson),
      deliveryAddress: json['deliveryAddress'] == null
          ? null
          : DeliveryAddressModel.fromJson(
              json['deliveryAddress'] as Map<String, dynamic>),
      products: (json['Products'] as List<dynamic>?)
          ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'totalPrice': instance.totalPrice,
      'paymentId': instance.paymentId,
      'paymentImageUrl': instance.paymentImageUrl,
      'deliveryAddressId': instance.deliveryAddressId,
      'createdAt': _$JsonConverterToJson<String, DateTime>(
          instance.createdAt, const CustomDateTimeConverter().toJson),
      'updatedAt': _$JsonConverterToJson<String, DateTime>(
          instance.updatedAt, const CustomDateTimeConverter().toJson),
      'deliveryAddress': instance.deliveryAddress?.toJson(),
      'Products': instance.products?.map((e) => e.toJson()).toList(),
      'status': instance.status,
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
