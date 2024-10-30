// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'support_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SupportModel {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "phoneNumbers")
  final List<String>? phoneNumbers;
  SupportModel({
    this.id,
    this.phoneNumbers,
  });

  factory SupportModel.fromJson(Map<String, dynamic> json) =>
      _$SupportModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$SupportModelToJson(this);

  static List<SupportModel> fromJsonList(List json) {
    return json
        .map((e) => SupportModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
