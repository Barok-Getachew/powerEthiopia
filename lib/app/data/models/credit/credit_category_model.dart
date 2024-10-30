// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'credit_category_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CreditCategoryModel {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "imageUrl")
  final String? imageUrl;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "creditType")
  final String? creditType;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  CreditCategoryModel({
    this.id,
    this.title,
    this.imageUrl,
    this.description,
    this.creditType,
    this.createdAt,
    this.updatedAt,
  });

  factory CreditCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CreditCategoryModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CreditCategoryModelToJson(this);

  static List<CreditCategoryModel> fromJsonList(List json) {
    return json
        .map((e) => CreditCategoryModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
