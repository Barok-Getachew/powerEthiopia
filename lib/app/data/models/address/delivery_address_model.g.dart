// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryAddressModel _$DeliveryAddressModelFromJson(
        Map<String, dynamic> json) =>
    DeliveryAddressModel(
      id: json['id'] as int?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      userId: json['userId'] as int?,
      contactName: json['name'] as String?,
    );

Map<String, dynamic> _$DeliveryAddressModelToJson(
        DeliveryAddressModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'address': instance.address,
      'city': instance.city,
      'phoneNumber': instance.phoneNumber,
      'userId': instance.userId,
      'name': instance.contactName,
    };
