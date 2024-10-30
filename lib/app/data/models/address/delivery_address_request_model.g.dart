// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_address_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryAddressRequestModel _$DeliveryAddressRequestModelFromJson(
        Map<String, dynamic> json) =>
    DeliveryAddressRequestModel(
      address: json['address'] as String,
      city: json['city'] as String,
      phoneNumber: json['phoneNumber'] as String,
      contactName: json['name'] as String,
      userId: json['userId'] as int,
    );

Map<String, dynamic> _$DeliveryAddressRequestModelToJson(
        DeliveryAddressRequestModel instance) =>
    <String, dynamic>{
      'address': instance.address,
      'city': instance.city,
      'phoneNumber': instance.phoneNumber,
      'name': instance.contactName,
      'userId': instance.userId,
    };
