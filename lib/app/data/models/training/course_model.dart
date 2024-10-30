// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'course_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CourseModel {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "subTitle")
  final String? subTitle;
  @JsonKey(name: "videoUrl")
  final String? videoUrl;
  @JsonKey(name: "pdfUrl")
  final String? pdfUrl;
  @JsonKey(name: "trainingId")
  final int? trainingId;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  CourseModel({
    this.id,
    this.title,
    this.subTitle,
    this.videoUrl,
    this.pdfUrl,
    this.trainingId,
    this.createdAt,
    this.updatedAt,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CourseModelToJson(this);

  static List<CourseModel> fromJsonList(List json) {
    return json
        .map((e) => CourseModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
