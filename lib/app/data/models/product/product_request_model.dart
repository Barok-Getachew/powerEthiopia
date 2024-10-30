// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'product_request_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductRequestModel {
  @JsonKey(name: "q")
  final String? searchTerm;
  ProductRequestModel({
    this.searchTerm,
  });

  factory ProductRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ProductRequestModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ProductRequestModelToJson(this);
}
