// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckoutRequestModel _$CheckoutRequestModelFromJson(
        Map<String, dynamic> json) =>
    CheckoutRequestModel(
      totalPrice: json['totalPrice'] as String?,
      paymentId: json['paymentId'] as String?,
      paymentImageUrl: json['paymentImageUrl'] as String?,
      deliveryLocation: json['deliveryLocation'] as String?,
      deliveryAddressId: json['deliveryAddressId'] as int?,
      userId: json['userId'] as int?,
      checkoutCart: (json['products'] as List<dynamic>?)
          ?.map((e) =>
              CheckoutCartRequestModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CheckoutRequestModelToJson(
        CheckoutRequestModel instance) =>
    <String, dynamic>{
      'totalPrice': instance.totalPrice,
      'paymentId': instance.paymentId,
      'paymentImageUrl': instance.paymentImageUrl,
      'deliveryLocation': instance.deliveryLocation,
      'deliveryAddressId': instance.deliveryAddressId,
      'userId': instance.userId,
      'products': instance.checkoutCart?.map((e) => e.toJson()).toList(),
    };
