// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'delivery_address_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DeliveryAddressModel {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "address")
  final String? address;
  @JsonKey(name: "city")
  final String? city;
  @JsonKey(name: "phoneNumber")
  final String? phoneNumber;
  @JsonKey(name: "userId")
  final int? userId;
  @JsonKey(name: "name")
  final String? contactName;
  DeliveryAddressModel({
    this.id,
    this.address,
    this.city,
    this.phoneNumber,
    this.userId,
    this.contactName,
  });

  factory DeliveryAddressModel.fromJson(Map<String, dynamic> json) =>
      _$DeliveryAddressModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$DeliveryAddressModelToJson(this);

  static List<DeliveryAddressModel> fromJsonList(List json) {
    return json
        .map((e) => DeliveryAddressModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
