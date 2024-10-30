// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'product_checkout_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductCheckoutModel {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "quantity")
  final int? quantity;
  ProductCheckoutModel({
    this.id,
    this.quantity,
  });

  factory ProductCheckoutModel.fromJson(Map<String, dynamic> json) =>
      _$ProductCheckoutModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ProductCheckoutModelToJson(this);
}
