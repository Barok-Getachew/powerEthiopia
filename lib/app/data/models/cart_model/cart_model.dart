// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import '../product/product_model.dart';

@JsonSerializable(explicitToJson: true)
class CartModel {
  final int? productId;
  final int? quantity;
  final ProductModel? product;
  CartModel({
    this.productId,
    this.quantity,
    this.product,
  });
}
