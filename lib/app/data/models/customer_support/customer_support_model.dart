import 'package:json_annotation/json_annotation.dart';

part 'customer_support_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CustomerSupportModel {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "phoneNumbers")
  final List<String>? phoneNumbers;
  @JsonKey(name: "createdAt")
  final DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  final DateTime? updatedAt;

  const CustomerSupportModel({
    this.id,
    this.phoneNumbers,
    this.createdAt,
    this.updatedAt,
  });

  factory CustomerSupportModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerSupportModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CustomerSupportModelToJson(this);

  static List<CustomerSupportModel> fromJsonList(List json) {
    return json
        .map((e) => CustomerSupportModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
