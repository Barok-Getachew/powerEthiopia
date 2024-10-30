// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      productId: json['productId'] as String?,
      trainingId: json['trainingId'] as String?,
      isSeen: json['isSeen'] as bool?,
      userId: json['userId'] as int?,
      createdAt: _$JsonConverterFromJson<String, DateTime>(
          json['createdAt'], const CustomDateTimeConverter().fromJson),
      updatedAt: _$JsonConverterFromJson<String, DateTime>(
          json['updatedAt'], const CustomDateTimeConverter().fromJson),
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'productId': instance.productId,
      'trainingId': instance.trainingId,
      'isSeen': instance.isSeen,
      'userId': instance.userId,
      'createdAt': _$JsonConverterToJson<String, DateTime>(
          instance.createdAt, const CustomDateTimeConverter().toJson),
      'updatedAt': _$JsonConverterToJson<String, DateTime>(
          instance.updatedAt, const CustomDateTimeConverter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
