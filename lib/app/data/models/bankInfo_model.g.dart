// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bankInfo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BankInfoImpl _$$BankInfoImplFromJson(Map<String, dynamic> json) =>
    _$BankInfoImpl(
      id: json['id'] as int?,
      name: json['name'] as String?,
      imageUrl: json['imageUrl'] as String?,
      accountNumber: json['accountNumber'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$$BankInfoImplToJson(_$BankInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'accountNumber': instance.accountNumber,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
