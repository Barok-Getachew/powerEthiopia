
import 'package:json_annotation/json_annotation.dart';

part 'onboarding_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AboutUsOnboarding {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "videoUrl")
  final String? videoUrl;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "pdfUrl")
  final String? pdfUrl;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "subTitle")
  final String? subTitle;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  AboutUsOnboarding({
    this.id,
    this.videoUrl,
    this.title,
    this.pdfUrl,
    this.description,
    this.subTitle,
    this.createdAt,
    this.updatedAt,
  });

  factory AboutUsOnboarding.fromJson(Map<String, dynamic> json) =>
      _$AboutUsOnboardingFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$AboutUsOnboardingToJson(this);

  static List<AboutUsOnboarding> fromJsonList(List json) {
    return json
        .map((e) => AboutUsOnboarding.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
