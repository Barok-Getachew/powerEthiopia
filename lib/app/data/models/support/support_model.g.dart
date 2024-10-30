// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportModel _$SupportModelFromJson(Map<String, dynamic> json) => SupportModel(
      id: json['id'] as int?,
      phoneNumbers: (json['phoneNumbers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$SupportModelToJson(SupportModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phoneNumbers': instance.phoneNumbers,
    };
