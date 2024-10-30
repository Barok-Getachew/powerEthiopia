// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRequestModel _$UserRequestModelFromJson(Map<String, dynamic> json) =>
    UserRequestModel(
      id: json['id'] as int?,
      fullName: json['fullName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      country: json['country'] as String?,
      description: json['description'] as String?,
      imageUrl: (json['imageUrl'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      password: json['password'] as String?,
      status: json['status'] as String?,
      role: json['role'] as String?,
      token: json['token'] as String?,
      startSubscription: json['startSubscription'] as bool?,
    );

Map<String, dynamic> _$UserRequestModelToJson(UserRequestModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'phoneNumber': instance.phoneNumber,
      'country': instance.country,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'password': instance.password,
      'status': instance.status,
      'role': instance.role,
      'token': instance.token,
      'startSubscription': instance.startSubscription,
    };
