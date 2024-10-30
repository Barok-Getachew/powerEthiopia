// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_response.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseResponseModel _$CourseResponseModelFromJson(Map<String, dynamic> json) =>
    CourseResponseModel(
      courseList: (json['courses'] as List<dynamic>?)
          ?.map((e) => CourseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CourseResponseModelToJson(
        CourseResponseModel instance) =>
    <String, dynamic>{
      'courses': instance.courseList?.map((e) => e.toJson()).toList(),
    };
