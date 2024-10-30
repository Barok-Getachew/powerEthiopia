// ignore_for_file: unnecessary_overrides

import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:ethiosolar_app/app/core/i18n/translation_keys.dart';

import 'package:ethiosolar_app/app/core/utils/media/image_picker.dart';
import 'package:ethiosolar_app/app/core/utils/media/media_type.dart';
import 'package:ethiosolar_app/app/data/models/bankInfo_model.dart';
import 'package:ethiosolar_app/app/data/models/checkout/checkout_request_model.dart';
import 'package:ethiosolar_app/app/data/models/user_model.dart';
import 'package:ethiosolar_app/app/data/services/api_client.dart';
import 'package:ethiosolar_app/app/data/services/api_constant.dart';
import 'package:ethiosolar_app/app/data/services/api_response.dart';
import 'package:ethiosolar_app/app/modules/cartScreen/controllers/cart_screen_controller.dart';
import 'package:ethiosolar_app/app/modules/profileScreen/controllers/delivery_address_controller.dart';
import 'package:ethiosolar_app/app/routes/app_pages.dart';
import 'package:ethiosolar_app/app/core/utils/store/user_session.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/i18n/translation_keys.dart' as trs;
import '../../../data/models/address/delivery_address_model.dart';

class CheckOutScreenController extends GetxController {
  DeliveryAddressModel? selectedDeliveryAddress;
  RxList<String> addresses = List<String>.empty(growable: true)
      .obs; // Replace with your list of addresses

  final ImagePickerUtil _imagePickerUtil = ImagePickerUtil();
  final MediaTypeUtil _mediaType = MediaTypeUtil();
  final RxList<BankInfo> bankList = List<BankInfo>.empty(growable: true).obs;
  UserModel userData = const UserModel();
  Rx<File>? selectedImageObs = File('').obs;

  RxBool isBankLoading = false.obs;
  String token = '';
  File? selectedImage;
  RxString fileNameObs = ''.obs;
  final data = <BankInfo>[].obs;
  RxBool isLoading = false.obs;
  String? filename;
  CheckoutRequestModel? checkoutRequest;

  RxInt selectedBankInfoId = RxInt(-1);
  RxString selectedBankName = RxString("");

  // String? fileName = fileNameObs.value;

  late DeliveryAddressController deliveryAddressController;

  Future<(File?, RxString)> selectPicture() async {
    final pickedImage =
        await _imagePickerUtil.getImage(source: ImageSource.gallery);
    selectedImageObs!.value = pickedImage.$1;

    selectedImage = pickedImage.$1;
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

  Future<void> getUserData() async {
    userData = (await UserSession.getUserData())!;
  }

  Future<void> doVerifyPayment() async {
    getUserData();
    getUserToken();
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
    if (selectedDeliveryAddress == null) {
      Get.snackbar(
        trs.error.tr,
        pleaseAddDeliveryAddress.tr,
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
      );

      if (responseUpload is BaseResponse) {
        debugPrint('image succesfull uplloaded ${responseUpload.results}');
        filename = responseUpload.results['filename'];
        debugPrint('filename $filename');
        debugPrint('token:$token');

        checkoutRequest = checkoutRequest!.copyWith(
          paymentId: selectedBankName.value.toString(),
          deliveryLocation: selectedDeliveryAddress!.address,
          paymentImageUrl: filename,
          deliveryAddressId: selectedDeliveryAddress!.id,
        );

        ApiResponse? response = await ApiClient.instance.call(
          params: checkoutRequest!.toJson(),
          token: token,
          mHeader: {
            'Content-Type': 'application/json',
          },
          endPoint: ApiConstant.kCheckout,
          method: ApiMethod.POST,
        );

        if (response is BaseResponse) {
          Get.snackbar(
            trs.success.tr,
            trs.successOrderApplied.tr,
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          debugPrint(
              ' succesful ${response.results}  response ${response.results.runtimeType}');
          Get.find<CartScreenController>().clearCart();
          Get.offAllNamed(Routes.home);

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
        } else {
          Get.snackbar(
            trs.error.tr,
            trs.someThingWentError.tr,
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
      // process response
    } catch (e) {
      Get.snackbar(
        trs.error.tr,
        trs.someThingWentError.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() async {
    super.onInit();
    if (Get.arguments != null) {
      checkoutRequest = Get.arguments;
    }
    deliveryAddressController = Get.find<DeliveryAddressController>();
    await getUserToken();
    await getUserData();
    await getBankList();
    await deliveryAddressController.getDeliveryAddress();
  }

  Map<String, dynamic> getRegPaymentReq({paymentMethod, paymentImageUrl, id}) {
    BankReq req = BankReq(
      paymentMethod: paymentMethod,
      userId: id,
      paymentImageUrl: paymentImageUrl,
    );
    return req.toJson();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void finishPayment() {}

  onTapBankInfo(BankInfo bankInfo) {
    selectedBankInfoId.value = bankInfo.id!;
    selectedBankName.value = bankInfo.name!;

    update(["bank"]);
  }

  onTapAddDeliveryAddress() async {
    await Get.toNamed(Routes.deliveryAddress);

    refresh();
  }
}
