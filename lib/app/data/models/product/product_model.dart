// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:ethiosolar_app/app/data/models/order/product_checkout_model.dart';

import '../custom_date_time_converter.dart';

part 'product_model.g.dart';

@JsonSerializable(explicitToJson: true)
@CustomDateTimeConverter()
class ProductModel {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "imageUrl")
  final dynamic imageUrl;
  @JsonKey(name: "videoUrl")
  final dynamic videoUrl;
  @JsonKey(name: "isInStock")
  final bool? isInStock;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "pdfUrl")
  final String? pdfUrl;
  @JsonKey(name: "price")
  final String? price;
  @JsonKey(name: "shortDescription")
  final String? shortDescription;
  @JsonKey(name: "createdAt")
  final DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  final DateTime? updatedAt;
  @JsonKey(name: "productCheckout")
  final ProductCheckoutModel? productCheckout;

  List<String>? get getImageUrl {
    if (imageUrl == null) {
      return null;
    }
    if (imageUrl.runtimeType == List<String>) {
      return imageUrl;
    }
    if (imageUrl.runtimeType == List<dynamic>) {
      return (imageUrl as List).map((e) => e as String).toList();
    }
    if (imageUrl.runtimeType == String) {
      final splitNames = imageUrl.split(',');
      List<String> splitList = [];
      for (int i = 0; i < splitNames.length; i++) {
        splitList.add(splitNames[i]);
      }
      return splitList;
    }
    return null;
  }

  ({List<String>? shopVideoUrl, String? orderVideoUrl})? get getVideoUrl {
    if (videoUrl == null) {
      return (shopVideoUrl: null, orderVideoUrl: null);
    }
    if (videoUrl.runtimeType == List<String>) {
      return (
        shopVideoUrl: (videoUrl as List).map((e) => e as String).toList(),
        orderVideoUrl: null
      );
    }
    if (videoUrl.runtimeType == String) {
      return (shopVideoUrl: null, orderVideoUrl: videoUrl);
    }
    return (shopVideoUrl: null, orderVideoUrl: null);
  }

  ProductModel({
    this.id,
    this.name,
    this.imageUrl,
    this.videoUrl,
    this.isInStock,
    this.description,
    this.pdfUrl,
    this.price,
    this.shortDescription,
    this.createdAt,
    this.updatedAt,
    this.productCheckout,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  static List<ProductModel> fromJsonList(List json) {
    return json
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
