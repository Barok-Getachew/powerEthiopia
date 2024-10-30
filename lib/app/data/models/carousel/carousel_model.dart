import 'package:json_annotation/json_annotation.dart';
part 'carousel_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CarouselModel {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "imageUrls")
  final List<String>? imageUrls;

  const CarouselModel({required this.id, required this.imageUrls});

  factory CarouselModel.fromJson(Map<String, dynamic> json) =>
      _$CarouselModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CarouselModelToJson(this);

  static List<CarouselModel> fromJsonList(List json) {
    return json
        .map((e) => CarouselModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
