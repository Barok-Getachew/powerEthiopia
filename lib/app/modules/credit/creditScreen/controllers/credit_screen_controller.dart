import 'dart:io';

import 'package:ethiosolar_app/app/data/models/credit/credit_category_model.dart';
import 'package:ethiosolar_app/app/data/models/credit/credit_response_model.dart';
import 'package:ethiosolar_app/app/data/services/api_client.dart';
import 'package:ethiosolar_app/app/data/services/api_constant.dart';
import 'package:ethiosolar_app/app/data/services/api_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/media/media_type.dart';

class CreditScreenController extends GetxController {
  final isCreditLoading = false.obs;
  final isApplyingCreditLoading = false.obs;
  final RxList<CreditCategoryModel> creditList =
      List<CreditCategoryModel>.empty(growable: true).obs;

  late TextEditingController fullNameController;
  late TextEditingController phoneNumberController;
  late TextEditingController amountController;
  late TextEditingController locationController;
  late GlobalKey<FormState> formKey;
  final MediaTypeUtil _mediaType = MediaTypeUtil();

  String? selectedCategoryId;
  File? selectedImage;
  RxString fileNameObs = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    getAllCreditCategory();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getAllCreditCategory() async {
    isCreditLoading(true);

    try {
      ApiResponse? response = await ApiClient.instance.call(
        method: ApiMethod.GET,
        params: {},
        endPoint: ApiConstant.kGetAllCreditCategories,
        useToken: true,
      );
      if (response is BaseResponse) {
        CreditResponseModel creditResponseModel = CreditResponseModel(
          creditCategoryList: CreditCategoryModel.fromJsonList(
            response.results,
          ),
        );
        creditList.addAll(creditResponseModel.creditCategoryList);
      }
    } catch (e) {
    } finally {
      isCreditLoading(false);
    }
  }
}
