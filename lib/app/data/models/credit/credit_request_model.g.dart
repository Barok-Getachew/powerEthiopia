// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditRequestModel _$CreditRequestModelFromJson(Map<String, dynamic> json) =>
    CreditRequestModel(
      fullName: json['fullName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      amount: json['amount'] as String,
      imageUrls:
          (json['imageUrls'] as List<dynamic>).map((e) => e as String).toList(),
      isApplied: json['isApplied'] as bool,
      creditCategoryId: json['creditCategoryId'] as String,
      userId: json['userId'] as String,
      fieldOfBusiness: json['fieldOfBusiness'] as String,
      tradeName: json['tradeName'] as String,
      creditType: json['creditType'] as String,
    );

Map<String, dynamic> _$CreditRequestModelToJson(CreditRequestModel instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'phoneNumber': instance.phoneNumber,
      'amount': instance.amount,
      'imageUrls': instance.imageUrls,
      'isApplied': instance.isApplied,
      'creditCategoryId': instance.creditCategoryId,
      'userId': instance.userId,
      'fieldOfBusiness': instance.fieldOfBusiness,
      'tradeName': instance.tradeName,
      'creditType': instance.creditType,
    };
