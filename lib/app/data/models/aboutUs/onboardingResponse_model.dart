// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ethiosolar_app/app/data/models/aboutUs/onboarding_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'onboardingResponse_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AboutUsOnBoardingResponse {
  @JsonKey(name: "onboardings")
  final List<AboutUsOnboarding>? onboardingList;
  AboutUsOnBoardingResponse({
    this.onboardingList,
  });

  factory AboutUsOnBoardingResponse.fromJson(Map<String, dynamic> json) =>
      _$AboutUsOnBoardingResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$AboutUsOnBoardingResponseToJson(this);

  static List<AboutUsOnBoardingResponse> fromJsonList(List json) {
    return json
        .map((e) =>
            AboutUsOnBoardingResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
