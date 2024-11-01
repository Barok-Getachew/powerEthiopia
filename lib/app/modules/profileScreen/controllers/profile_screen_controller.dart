// ignore_for_file: unnecessary_overrides

import 'package:ethiosolar_app/app/core/i18n/translation_keys.dart';
import 'package:ethiosolar_app/app/data/models/about/aboutUs_model.dart';
import 'package:ethiosolar_app/app/data/models/customer_support/customer_support_model.dart';
import 'package:ethiosolar_app/app/data/models/customer_support/customer_support_response.dart';
import 'package:ethiosolar_app/app/data/models/feedback_request_model.dart';
import 'package:ethiosolar_app/app/data/models/term_condition/term_condition_model.dart';
import 'package:ethiosolar_app/app/data/models/term_condition/term_response_model.dart';
import 'package:ethiosolar_app/app/data/models/user_model.dart';
import 'package:ethiosolar_app/app/data/services/api_client.dart';
import 'package:ethiosolar_app/app/data/services/api_constant.dart';
import 'package:ethiosolar_app/app/data/services/api_response.dart';
import 'package:ethiosolar_app/app/routes/app_pages.dart';
import 'package:ethiosolar_app/app/core/utils/store/user_session.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreenController extends GetxController {
  AboutUsModel? aboutUsModel;
  TermModel? termModel;
  RxBool isCustomerLoading = true.obs;
  final RxList<CustomerSupportModel> customerSupportList =
      List<CustomerSupportModel>.empty(growable: true).obs;

  final RxList<TermModel> termModelList =
      List<TermModel>.empty(growable: true).obs;

  UserModel? userModel;

  final count = 0.obs;

  RxBool isLoading = true.obs;
  RxBool isAboutLoading = false.obs;
  RxBool isSupportLoading = false.obs;
  RxBool isTermLoading = false.obs;
  RxBool isAddFeedbackLoading = false.obs;
  late TextEditingController feedbackController;
  late GlobalKey<FormState> formKey;
  RxBool isLogoutLoading = false.obs;

  @override
  void onInit() async {
    formKey = GlobalKey<FormState>();
    feedbackController = TextEditingController();
    await getUserData();
    await getAboutUs();
    super.onInit();
  }

  @override
  void onReady() async {
    await getUserData();
    await getSupport();
    await getTerm();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  Future<void> getUserData() async {
    isLoading(true);
    userModel = await UserSession.getUserData();
    isLoading(false);
  }

  //logout
  Future<void> logout() async {
    // ...
    try {
      isLogoutLoading.value = true;
      ApiResponse? response = await ApiClient.instance.call(
        method: ApiMethod.PUT,
        params: {'isLoggedIn': false, 'phoneNumber': userModel!.phoneNumber},
        endPoint: "${ApiConstant.kgetUser}${userModel!.id}",
      );
      if (response is BaseResponse) {
        // Handle success response
        isLogoutLoading.value = false;
        UserSession.setUserToken('');
        UserSession.setUserData(UserModel());

        Get.offAllNamed(Routes.login);
      }
    } finally {
      isLogoutLoading.value = false;
    }
  }

  void addFeedback(String feedback) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    formKey.currentState?.save();
    isAddFeedbackLoading(true);
    try {
      final request = FeedbackRequestModel(
        description: feedback,
        userId: await UserSession.getUserId(),
      );
      ApiResponse? response = await ApiClient.instance.call(
        method: ApiMethod.POST,
        params: request.toJson(),
        endPoint: ApiConstant.kFeedback,
      );
      if (response is BaseResponse) {}
    } finally {
      isAddFeedbackLoading(false);
      feedbackController.clear();
      Get.back();
      Get.snackbar(success.tr, thanksForFeedback.tr);
    }
  }

  Future<void> getAboutUs() async {
    isAboutLoading(true);
    try {
      final ApiResponse? response = await ApiClient.instance.call(
        method: ApiMethod.GET,
        endPoint: "${ApiConstant.kAboutUs}/1",
        useToken: true,
      );
      if (response is BaseResponse) {
        aboutUsModel = AboutUsModel.fromJson(response.results);
      }
    } finally {
      isAboutLoading(false);
    }
  }

  Future<void> getTerm() async {
    isAboutLoading(true);
    try {
      final ApiResponse? response = await ApiClient.instance.call(
        method: ApiMethod.GET,
        endPoint: ApiConstant.kgetTermAndCondition,
        useToken: true,
      );
      if (response is BaseResponse) {
        final TermResponseModel termResponse = TermResponseModel(
          termList: TermModel.fromJsonList(
            response.results,
          ),
        );
        termModelList.addAll(termResponse.termList);
      }
    } finally {
      isAboutLoading(false);
    }
  }

  Future<void> getSupport() async {
    isCustomerLoading(true);
    try {
      ApiResponse? response = await ApiClient.instance.call(
        method: ApiMethod.GET,
        params: {},
        endPoint: ApiConstant.kGetSupport,
        useToken: true,
      );
      if (response is BaseResponse) {
        final CustomerSupportResponse customerResponse =
            CustomerSupportResponse(
          customerSupportList: CustomerSupportModel.fromJsonList(
            response.results,
          ),
        );
        customerSupportList.addAll(customerResponse.customerSupportList);
      }
    } finally {
      isCustomerLoading(false);
    }
  }
}
