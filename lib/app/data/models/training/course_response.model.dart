// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ethiosolar_app/app/data/models/training/course_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course_response.model.g.dart';

@JsonSerializable(explicitToJson: true)
class CourseResponseModel {
  @JsonKey(name: "courses")
  final List<CourseModel>? courseList;
  CourseResponseModel({
    this.courseList,
  });

  factory CourseResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseResponseModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CourseResponseModelToJson(this);

  static List<CourseResponseModel> fromJsonList(List json) {
    return json
        .map((e) => CourseResponseModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
