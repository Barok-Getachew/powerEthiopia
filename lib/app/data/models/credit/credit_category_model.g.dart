// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditCategoryModel _$CreditCategoryModelFromJson(Map<String, dynamic> json) =>
    CreditCategoryModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      imageUrl: json['imageUrl'] as String?,
      description: json['description'] as String?,
      creditType: json['creditType'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$CreditCategoryModelToJson(
        CreditCategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'description': instance.description,
      'creditType': instance.creditType,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
