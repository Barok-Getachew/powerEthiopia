import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:ethiosolar_app/app/core/i18n/translation_keys.dart';
import 'package:ethiosolar_app/app/core/utils/media/image_picker.dart';
import 'package:ethiosolar_app/app/core/utils/media/media_type.dart';
import 'package:ethiosolar_app/app/data/models/bankInfo_model.dart';
import 'package:ethiosolar_app/app/data/models/user_model.dart';
import 'package:ethiosolar_app/app/data/services/api_client.dart';
import 'package:ethiosolar_app/app/data/services/api_constant.dart';
import 'package:ethiosolar_app/app/data/services/api_response.dart';
import 'package:ethiosolar_app/app/routes/app_pages.dart';
import 'package:ethiosolar_app/app/core/utils/store/user_session.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/i18n/translation_keys.dart' as trs;

class RegistrationPaymentController extends GetxController {
  final ImagePickerUtil _imagePickerUtil = ImagePickerUtil();
  final MediaTypeUtil _mediaType = MediaTypeUtil();
  final RxList<BankInfo> bankList = List<BankInfo>.empty(growable: true).obs;
  UserModel userData = const UserModel();
  late int userId;
  RxBool isBankLoading = false.obs;
  String token = '';
  File? selectedImage;
  RxInt selectedBankInfoId = RxInt(-1);
  RxString selectedBankInfoName = RxString("");

  Rx<File>? selectedImageObs = File('').obs;

  RxString fileNameObs = ''.obs;
  final data = <BankInfo>[].obs;
  RxBool isLoading = false.obs;
  String? filename;

  // String? fileName = fileNameObs.value;
  onTapBankInfo(BankInfo bankInfo) {
    selectedBankInfoId.value = bankInfo.id!;
    selectedBankInfoName.value = bankInfo.name!;
    update(["bank"]);
  }

  Future<(File?, RxString)> selectPicture() async {
    final pickedImage =
        await _imagePickerUtil.getImage(source: ImageSource.gallery);

    selectedImage = pickedImage.$1;
    selectedImageObs!.value = pickedImage.$1;
    fileNameObs.value = pickedImage.$2;
    // fileName = (pickedImage.$2).obs.value;

    // debugPrint("file name$selectedImage2");
    return (selectedImage, fileNameObs);
  }

  Future<void> getBankList() async {
    try {
      isBankLoading(true);

      ApiResponse? response = await ApiClient.instance.call(
        method: ApiMethod.GET,
        // params: trainingRequest,
        endPoint: ApiConstant.kgetBanks,
      );
      if (response is BaseResponse) {
        debugPrint('responseBank1st: ${response.results.toString()}');

        List<BankInfo> bankResult = [];
        for (var item in (response.results as List<dynamic>)) {
          bankResult.add(BankInfo.fromJson(item));
        }
        debugPrint('responseBanksnd: $bankResult');

        bankList.value = bankResult;
        debugPrint('responseBank3rd: $bankList');
      }
    } finally {
      isBankLoading(false);
    }
  }

  Future<void> getUserToken() async {
    token = await UserSession.getUserToken();
  }

  Future<void> doVerifyPayment({required String userId}) async {
    if (selectedImage == null) {
      Get.snackbar(
        trs.error.tr,
        trs.pleaseUploadPaymentImage.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    if (selectedBankInfoId.value == -1) {
      Get.snackbar(
        trs.error.tr,
        pleaseSelectBank.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      dio.FormData formDatas = dio.FormData.fromMap({
        "file": await dio.MultipartFile.fromFile(selectedImage!.path,
            filename: selectedImage!.path.split('/').last,
            contentType:
                _mediaType.getMediaType(selectedImage!.path.split('/').last))
      });

      ApiResponse? responseUpload = await ApiClient.instance.call(
        mHeader: {
          'Content-Type': 'multipart/form-data',
        },
        endPoint: ApiConstant.kuploadSingleImage,
        method: ApiMethod.MULTIPART,
        fileUploadData: formDatas,
        // params: params
      );

      if (responseUpload is BaseResponse) {
        debugPrint('image succesfull uplloaded ${responseUpload.results}');
        filename = responseUpload.results['filename'];
        debugPrint('filename $filename');
        Map<String, dynamic> params = getRegPaymentReq(
          userId: int.parse(userId),
          paymentImageUrl: filename ?? '',
          paymentMethod: selectedBankInfoName.value,
        );
        debugPrint('token:$token');
        debugPrint('params:$params');

        ApiResponse? response = await ApiClient.instance.call(
          params: params,
          token: token,
          mHeader: {
            'Content-Type': 'application/json',
          },
          endPoint: ApiConstant.kpostRegPayment,
          method: ApiMethod.POST,
        );

        if (response is BaseResponse) {
          debugPrint(
              ' succesful ${response.results}  response ${response.results.runtimeType}');
          Get.offAllNamed(Routes.login);

          // if (response.results
          //     .toString()
          //     .contains("User with this phone number already exists")) {
          isLoading.value = false;
        } else if (responseUpload is ErrorResponse) {
          Get.snackbar(
            trs.error.tr,
            responseUpload.data,
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          isLoading.value = false;
        } else {
          Get.snackbar(
            trs.error.tr,
            trs.someThingWentError.tr,
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          isLoading.value = false;
        }
      }
      // process response
    } catch (e) {
      isLoading.value = false;

      Get.snackbar(
        trs.error.tr,
        trs.someThingWentError.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await getBankList();
    await getUserToken();

    userId = int.parse(userData.id.toString());
  }

  Map<String, dynamic> getRegPaymentReq(
      {required String paymentMethod,
      required String paymentImageUrl,
      required int userId}) {
    BankReq req = BankReq(
      paymentMethod: paymentMethod,
      userId: userId,
      paymentImageUrl: paymentImageUrl,
    );
    return req.toJson();
  }
}
