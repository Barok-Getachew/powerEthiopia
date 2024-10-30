// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ethiosolar_app/app/data/models/city/city_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'city_responnse_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CityResponseModel {
  @JsonKey(name: "cities")
  final List<CityModel>? cityList;
  CityResponseModel({
    this.cityList,
  });

  factory CityResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CityResponseModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CityResponseModelToJson(this);

  static List<CityResponseModel> fromJsonList(List json) {
    return json
        .map((e) => CityResponseModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
