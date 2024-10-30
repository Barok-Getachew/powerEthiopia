// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrainingResponseModel _$TrainingResponseModelFromJson(
        Map<String, dynamic> json) =>
    TrainingResponseModel(
      trainingList: (json['trainings'] as List<dynamic>?)
          ?.map((e) => TrainingModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TrainingResponseModelToJson(
        TrainingResponseModel instance) =>
    <String, dynamic>{
      'trainings': instance.trainingList?.map((e) => e.toJson()).toList(),
    };
