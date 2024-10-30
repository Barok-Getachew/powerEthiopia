import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'bankInfo_model.freezed.dart';
part 'bankInfo_model.g.dart';

@freezed
class BankInfo with _$BankInfo {
  const factory BankInfo({
    int? id,
    String? name,
    String? imageUrl,
    String? accountNumber,
    String? createdAt,
    String? updatedAt,
  }) = _BankInfo;

  factory BankInfo.fromJson(Map<String, dynamic> json) =>
      _$BankInfoFromJson(json);
}

class BankReq {
  final String paymentMethod;
  final String paymentImageUrl;
  final int userId;
  BankReq({
    required this.paymentMethod,
    required this.paymentImageUrl,
    required this.userId,
  });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paymentMethod'] = paymentMethod;
    data['paymentImageUrl'] = paymentImageUrl;
    data['userId'] = userId;

    return data;
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'paymentMethod': paymentMethod});
    result.addAll({'paymentImageUrl': paymentImageUrl});
    result.addAll({'userId': userId});

    return result;
  }

  factory BankReq.fromMap(Map<String, dynamic> map) {
    return BankReq(
      paymentMethod: map['paymentMethod'] ?? '',
      paymentImageUrl: map['paymentImageUrl'] ?? '',
      userId: map['userId']?.toInt() ?? 0,
    );
  }

  factory BankReq.fromJson(String source) =>
      BankReq.fromMap(json.decode(source));
}
