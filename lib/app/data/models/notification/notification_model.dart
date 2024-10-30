// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ethiosolar_app/app/data/models/custom_date_time_converter.dart';

part 'notification_model.g.dart';

@JsonSerializable(explicitToJson: true)
@CustomDateTimeConverter()
class NotificationModel {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "productId")
  final String? productId;
  @JsonKey(name: "trainingId")
  final String? trainingId;
  @JsonKey(name: "isSeen")
  final bool? isSeen;
  @JsonKey(name: "userId")
  final int? userId;
  @JsonKey(name: "createdAt")
  final DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  final DateTime? updatedAt;
  NotificationModel({
    this.id,
    this.title,
    this.description,
    this.productId,
    this.trainingId,
    this.isSeen,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  static List<NotificationModel> fromJsonList(List json) {
    return json
        .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
