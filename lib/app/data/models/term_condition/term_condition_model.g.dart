// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'term_condition_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TermModel _$TermModelFromJson(Map<String, dynamic> json) => TermModel(
      id: json['id'] as int?,
      pdfUrl: json['pdfUrl'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$TermModelToJson(TermModel instance) => <String, dynamic>{
      'id': instance.id,
      'pdfUrl': instance.pdfUrl,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
