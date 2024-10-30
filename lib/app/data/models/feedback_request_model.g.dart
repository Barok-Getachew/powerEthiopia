// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedbackRequestModel _$FeedbackRequestModelFromJson(
        Map<String, dynamic> json) =>
    FeedbackRequestModel(
      description: json['description'] as String?,
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$FeedbackRequestModelToJson(
        FeedbackRequestModel instance) =>
    <String, dynamic>{
      'description': instance.description,
      'userId': instance.userId,
    };
