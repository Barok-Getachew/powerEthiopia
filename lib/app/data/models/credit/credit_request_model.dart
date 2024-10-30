// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'credit_request_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CreditRequestModel {
  @JsonKey(name: "fullName")
  final String fullName;
  @JsonKey(name: "phoneNumber")
  final String phoneNumber;
  @JsonKey(name: "amount")
  final String amount;
  @JsonKey(name: "imageUrls")
  final List<String> imageUrls;
  @JsonKey(name: "isApplied")
  final bool isApplied;
  @JsonKey(name: "creditCategoryId")
  final String creditCategoryId;
  @JsonKey(name: "userId")
  final String userId;
  @JsonKey(name: "fieldOfBusiness")
  final String fieldOfBusiness;
  @JsonKey(name: "tradeName")
  final String tradeName;
  @JsonKey(name: "creditType")
  final String creditType;
  CreditRequestModel({
    required this.fullName,
    required this.phoneNumber,
    required this.amount,
    required this.imageUrls,
    required this.isApplied,
    required this.creditCategoryId,
    required this.userId,
    required this.fieldOfBusiness,
    required this.tradeName,
    required this.creditType,
  });

  factory CreditRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CreditRequestModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CreditRequestModelToJson(this);
}
