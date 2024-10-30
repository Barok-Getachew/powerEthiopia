// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'training_request_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TrainingRequestModel {
  final int? id;
  const TrainingRequestModel({
    this.id,
  });

  factory TrainingRequestModel.fromJson(Map<String, dynamic> json) =>
      _$TrainingRequestModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$TrainingRequestModelToJson(this);
}
