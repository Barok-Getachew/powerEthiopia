// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'training_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TrainingModel {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "imageUrl")
  final String? imageUrl;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  TrainingModel({
    this.id,
    this.title,
    this.description,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory TrainingModel.fromJson(Map<String, dynamic> json) =>
      _$TrainingModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$TrainingModelToJson(this);

  static List<TrainingModel> fromJsonList(List json) {
    return json
        .map((e) => TrainingModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
