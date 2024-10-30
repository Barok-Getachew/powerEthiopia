// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'city_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CityModel {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
 
  CityModel({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) =>
      _$CityModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CityModelToJson(this);

  static List<CityModel> fromJsonList(List json) {
    return json
        .map((e) => CityModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
