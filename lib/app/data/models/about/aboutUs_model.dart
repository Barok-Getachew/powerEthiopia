import 'package:json_annotation/json_annotation.dart';

part 'aboutUs_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AboutUsModel {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "pdfUrl")
  final String? pdfUrl;
  @JsonKey(name: "websiteUrl")
  final String? websiteUrl;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  AboutUsModel({
    this.id,
    this.title,
    this.pdfUrl,
    this.websiteUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory AboutUsModel.fromJson(Map<String, dynamic> json) =>
      _$AboutUsModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$AboutUsModelToJson(this);

  static List<AboutUsModel> fromJsonList(List json) {
    return json
        .map((e) => AboutUsModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
