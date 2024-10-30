import 'package:json_annotation/json_annotation.dart';

part 'term_condition_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TermModel {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "pdfUrl")
  final String? pdfUrl;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  TermModel({
    this.id,
    this.pdfUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory TermModel.fromJson(Map<String, dynamic> json) =>
      _$TermModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$TermModelToJson(this);

  static List<TermModel> fromJsonList(List json) {
    return json
        .map((e) => TermModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
