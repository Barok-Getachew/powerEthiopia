// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_support_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerSupportModel _$CustomerSupportModelFromJson(
        Map<String, dynamic> json) =>
    CustomerSupportModel(
      id: json['id'] as int?,
      phoneNumbers: (json['phoneNumbers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CustomerSupportModelToJson(
        CustomerSupportModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phoneNumbers': instance.phoneNumbers,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
