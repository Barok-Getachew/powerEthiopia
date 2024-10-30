// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:ethiosolar_app/app/data/models/checkout/checkout_cart_request_model.dart';

part 'checkout_request_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CheckoutRequestModel {
  @JsonKey(name: "totalPrice")
  final String? totalPrice;
  @JsonKey(name: "paymentId")
  final String? paymentId;
  @JsonKey(name: "paymentImageUrl")
  final String? paymentImageUrl;
  @JsonKey(name: "deliveryLocation")
  final String? deliveryLocation;
  @JsonKey(name: "deliveryAddressId")
  final int? deliveryAddressId;
  @JsonKey(name: "userId")
  final int? userId;
  @JsonKey(name: "products")
  final List<CheckoutCartRequestModel>? checkoutCart;
  CheckoutRequestModel({
    this.totalPrice,
    this.paymentId,
    this.paymentImageUrl,
    this.deliveryLocation,
    this.deliveryAddressId,
    this.userId,
    this.checkoutCart,
  });

  factory CheckoutRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CheckoutRequestModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CheckoutRequestModelToJson(this);

  CheckoutRequestModel copyWith({
    String? totalPrice,
    String? paymentId,
    String? paymentImageUrl,
    String? deliveryLocation,
    int? deliveryAddressId,
    int? userId,
    List<CheckoutCartRequestModel>? checkoutCart,
  }) {
    return CheckoutRequestModel(
      totalPrice: totalPrice ?? this.totalPrice,
      paymentId: paymentId ?? this.paymentId,
      paymentImageUrl: paymentImageUrl ?? this.paymentImageUrl,
      deliveryLocation: deliveryLocation ?? this.deliveryLocation,
      deliveryAddressId: deliveryAddressId ?? this.deliveryAddressId,
      userId: userId ?? this.userId,
      checkoutCart: checkoutCart ?? this.checkoutCart,
    );
  }
}
