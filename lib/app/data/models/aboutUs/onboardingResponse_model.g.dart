// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboardingResponse_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AboutUsOnBoardingResponse _$AboutUsOnBoardingResponseFromJson(
        Map<String, dynamic> json) =>
    AboutUsOnBoardingResponse(
      onboardingList: (json['onboardings'] as List<dynamic>?)
          ?.map((e) => AboutUsOnboarding.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AboutUsOnBoardingResponseToJson(
        AboutUsOnBoardingResponse instance) =>
    <String, dynamic>{
      'onboardings': instance.onboardingList?.map((e) => e.toJson()).toList(),
    };
