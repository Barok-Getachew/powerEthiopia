// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:core';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_request_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserRequestModel {
  final int? id;
  final String? fullName;
  final String? phoneNumber;
  final String? country;
  final String? description;
  final List<String>? imageUrl;
  final String? password;
  final String? status;
  final String? role;
  final String? token;
  final bool? startSubscription;
  UserRequestModel({
    this.id,
    this.fullName,
    this.phoneNumber,
    this.country,
    this.description,
    this.imageUrl,
    this.password,
    this.status,
    this.role,
    this.token,
    this.startSubscription,
  });

  factory UserRequestModel.fromJson(Map<String, dynamic> json) =>
      _$UserRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserRequestModelToJson(this);
}
