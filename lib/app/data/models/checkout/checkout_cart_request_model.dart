// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'checkout_cart_request_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CheckoutCartRequestModel {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "quantity")
  final int? quantity;
  CheckoutCartRequestModel({
    this.id,
    this.quantity,
  });

  factory CheckoutCartRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CheckoutCartRequestModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CheckoutCartRequestModelToJson(this);
}
