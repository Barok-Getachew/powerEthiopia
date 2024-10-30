// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseModel _$CourseModelFromJson(Map<String, dynamic> json) => CourseModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      subTitle: json['subTitle'] as String?,
      videoUrl: json['videoUrl'] as String?,
      pdfUrl: json['pdfUrl'] as String?,
      trainingId: json['trainingId'] as int?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$CourseModelToJson(CourseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subTitle': instance.subTitle,
      'videoUrl': instance.videoUrl,
      'pdfUrl': instance.pdfUrl,
      'trainingId': instance.trainingId,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
