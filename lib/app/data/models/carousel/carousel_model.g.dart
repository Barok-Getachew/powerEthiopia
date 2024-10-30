// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carousel_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarouselModel _$CarouselModelFromJson(Map<String, dynamic> json) =>
    CarouselModel(
      id: json['id'] as int?,
      imageUrls: (json['imageUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CarouselModelToJson(CarouselModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imageUrls': instance.imageUrls,
    };
