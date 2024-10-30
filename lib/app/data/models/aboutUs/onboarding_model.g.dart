// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AboutUsOnboarding _$AboutUsOnboardingFromJson(Map<String, dynamic> json) =>
    AboutUsOnboarding(
      id: json['id'] as int?,
      videoUrl: json['videoUrl'] as String?,
      title: json['title'] as String?,
      pdfUrl: json['pdfUrl'] as String?,
      description: json['description'] as String?,
      subTitle: json['subTitle'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$AboutUsOnboardingToJson(AboutUsOnboarding instance) =>
    <String, dynamic>{
      'id': instance.id,
      'videoUrl': instance.videoUrl,
      'title': instance.title,
      'pdfUrl': instance.pdfUrl,
      'description': instance.description,
      'subTitle': instance.subTitle,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
