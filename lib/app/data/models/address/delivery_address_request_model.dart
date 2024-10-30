// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

part 'delivery_address_request_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DeliveryAddressRequestModel {
  @JsonKey(name: "address")
  final String address;
  @JsonKey(name: "city")
  final String city;
  @JsonKey(name: "phoneNumber")
  final String phoneNumber;
  @JsonKey(name: "name")
  final String contactName;
  @JsonKey(name: "userId")
  final int userId;
  DeliveryAddressRequestModel({
    required this.address,
    required this.city,
    required this.phoneNumber,
    required this.contactName,
    required this.userId,
  });

  factory DeliveryAddressRequestModel.fromJson(Map<String, dynamic> json) =>
      _$DeliveryAddressRequestModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$DeliveryAddressRequestModelToJson(this);
}
