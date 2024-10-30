// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aboutUs_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AboutUsModel _$AboutUsModelFromJson(Map<String, dynamic> json) => AboutUsModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      pdfUrl: json['pdfUrl'] as String?,
      websiteUrl: json['websiteUrl'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$AboutUsModelToJson(AboutUsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'pdfUrl': instance.pdfUrl,
      'websiteUrl': instance.websiteUrl,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
