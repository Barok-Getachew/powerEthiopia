// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ethiosolar_app/app/data/models/training/training_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'training_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TrainingResponseModel {
  @JsonKey(name: "trainings")
  final List<TrainingModel>? trainingList;
  TrainingResponseModel({
    this.trainingList,
  });

  factory TrainingResponseModel.fromJson(Map<String, dynamic> json) =>
      _$TrainingResponseModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$TrainingResponseModelToJson(this);

  static List<TrainingResponseModel> fromJsonList(List json) {
    return json
        .map((e) => TrainingResponseModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
