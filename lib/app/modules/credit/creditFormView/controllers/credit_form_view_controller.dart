// ignore_for_file: unnecessary_overrides

import 'dart:io';

import 'package:ethiosolar_app/app/core/i18n/translation_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/utils/media/image_picker.dart';
import '../../../../core/utils/media/media_type.dart';
import '../../../../data/models/credit/credit_request_model.dart';
import '../../../../data/services/api_client.dart';
import '../../../../data/services/api_constant.dart';
import '../../../../data/services/api_response.dart';
import '../../../../core/utils/store/user_session.dart';
import 'package:dio/dio.dart' as dio;

class CreditFormViewController extends GetxController {
  late TextEditingController fullNameController;
  late TextEditingController phoneNumberController;
  late TextEditingController addressController;
  late TextEditingController creditAmountController;
  late TextEditingController fieldOfBusinessController;
  late TextEditingController tradeNameController;

  late FocusNode fullNameFocusNode;
  late FocusNode phoneNumberFocusNode;
  late FocusNode addressFocusNode;
  late FocusNode creditAmountFocusNode;
  late FocusNode fieldOfBusinessFocusNode;
  late FocusNode tradeNameFocusNode;

  final count = 0.obs;
  late GlobalKey<FormState> formKey;
  final MediaTypeUtil _mediaType = MediaTypeUtil();

  String? selectedCategoryId;
  File? selectedImage;
  Rx<File>? selectedImageObs = File('').obs;

  RxString fileNameObs = ''.obs;
  final isApplyingCreditLoading = false.obs;
  final ImagePickerUtil _imagePickerUtil = ImagePickerUtil();
  String creditType = "";
  @override
  void onInit() {
    if (Get.parameters.isNotEmpty) {
      creditType = Get.parameters.containsKey("creditType")
          ? Get.parameters["creditType"] ?? ""
          : "";
    }
    fullNameController = TextEditingController();
    phoneNumberController = TextEditingController();
    addressController = TextEditingController();
    creditAmountController = TextEditingController();
    fieldOfBusinessController = TextEditingController();
    tradeNameController = TextEditingController();
    formKey = GlobalKey<FormState>();

    fullNameFocusNode = FocusNode();
    phoneNumberFocusNode = FocusNode();
    addressFocusNode = FocusNode();
    creditAmountFocusNode = FocusNode();
    fieldOfBusinessFocusNode = FocusNode();
    tradeNameFocusNode = FocusNode();

    if (Get.arguments != null) {
      selectedCategoryId = Get.arguments;
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> applyForCredit() async {
    if (selectedCategoryId == null) {
      Get.snackbar('Error', 'Credit has not been chosen');
      return;
    }

    if (selectedImage == null) {
      Get.snackbar(error.tr, pleaseUpload.tr);
      return;
    }

    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    formKey.currentState!.save();

    final String userId = await UserSession.getUserId();
    isApplyingCreditLoading(true);
    dio.FormData formDatas = dio.FormData.fromMap({
      "file": await dio.MultipartFile.fromFile(selectedImage!.path,
          filename: selectedImage!.path.split('/').last,
          contentType:
              _mediaType.getMediaType(selectedImage!.path.split('/').last))
    });

    try {
      ApiResponse? responseUpload = await ApiClient.instance.call(
        mHeader: {
          'Content-Type': 'multipart/form-data',
        },
        endPoint: ApiConstant.kuploadSingleImage,
        method: ApiMethod.MULTIPART,
        fileUploadData: formDatas,
      );
      if (responseUpload is BaseResponse) {
        final String filename = responseUpload.results['filename'];
        final request = CreditRequestModel(
          fullName: fullNameController.text,
          phoneNumber: phoneNumberController.text,
          amount: creditAmountController.text,
          imageUrls: [filename, "image url"],
          isApplied: true,
          creditCategoryId: selectedCategoryId!,
          userId: userId,
          tradeName: tradeNameController.text,
          fieldOfBusiness: fieldOfBusinessController.text,
          creditType: creditType,
        );
        ApiResponse? response = await ApiClient.instance.call(
            useToken: true,
            endPoint: ApiConstant.kApplyForCredit,
            method: ApiMethod.POST,
            params: request.toJson(),
            mHeader: {
              'Content-Type': 'application/json',
            });
        if (response is BaseResponse) {
          isApplyingCreditLoading(false);
          Get.snackbar(success.tr, successCreditApplied.tr,
              duration: const Duration(seconds: 2));
          await Future.delayed(const Duration(seconds: 4));
          Get.back();
        }
      }
    } finally {
      isApplyingCreditLoading(false);
    }
  }

  Future<(File?, RxString)> selectPicture() async {
    final pickedImage =
        await _imagePickerUtil.getImage(source: ImageSource.gallery);

    selectedImage = pickedImage.$1;
    selectedImageObs!.value = pickedImage.$1;
    fileNameObs.value = pickedImage.$2;

    return (selectedImage, fileNameObs);
  }
}
