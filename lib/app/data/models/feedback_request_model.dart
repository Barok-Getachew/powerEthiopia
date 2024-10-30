// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:freezed_annotation/freezed_annotation.dart';

part 'feedback_request_model.g.dart';

@JsonSerializable(explicitToJson: true)
class FeedbackRequestModel {
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "userId")
  final String? userId;
  FeedbackRequestModel({
    this.description,
    this.userId,
  });

  factory FeedbackRequestModel.fromJson(Map<String, dynamic> json) =>
      _$FeedbackRequestModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$FeedbackRequestModelToJson(this);
}
