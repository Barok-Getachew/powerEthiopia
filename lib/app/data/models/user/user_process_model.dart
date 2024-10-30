import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_process_model.freezed.dart';
part 'user_process_model.g.dart';

@freezed
class UserProcessModel with _$UserProcessModel {
  const factory UserProcessModel({
    int? userId,
  }) = _UserProcessModel;

  factory UserProcessModel.fromJson(Map<String, dynamic> json) =>
      _$UserProcessModelFromJson(json);
}
