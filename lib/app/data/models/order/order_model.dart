// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ethiosolar_app/app/data/models/custom_date_time_converter.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:ethiosolar_app/app/data/models/address/delivery_address_model.dart';
import 'package:ethiosolar_app/app/data/models/product/product_model.dart';

part 'order_model.g.dart';

@JsonSerializable(explicitToJson: true)
@CustomDateTimeConverter()
class OrderModel {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "totalPrice")
  final String? totalPrice;
  @JsonKey(name: "paymentId")
  final String? paymentId;
  @JsonKey(name: "paymentImageUrl")
  final String? paymentImageUrl;
  @JsonKey(name: "deliveryAddressId")
  final int? deliveryAddressId;
  @JsonKey(name: "createdAt")
  final DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  final DateTime? updatedAt;
  @JsonKey(name: "deliveryAddress")
  final DeliveryAddressModel? deliveryAddress;
  @JsonKey(name: "Products")
  final List<ProductModel>? products;
  @JsonKey(name: "status")
  final String? status;
  OrderModel({
    this.id,
    this.totalPrice,
    this.paymentId,
    this.paymentImageUrl,
    this.deliveryAddressId,
    this.createdAt,
    this.updatedAt,
    this.deliveryAddress,
    required this.products,
    this.status,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  static List<OrderModel> fromJsonList(List json) {
    return json
        .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
