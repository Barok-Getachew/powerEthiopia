import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:ethiosolar_app/app/core/utils/media/image_picker.dart';
import 'package:ethiosolar_app/app/data/models/city/city_model.dart';
import 'package:ethiosolar_app/app/data/models/city/city_responnse_model.dart';
import 'package:ethiosolar_app/app/data/models/user/user_request_model.dart';
import 'package:ethiosolar_app/app/data/models/user_model.dart';
import 'package:ethiosolar_app/app/data/services/api_client.dart';
import 'package:ethiosolar_app/app/data/services/api_constant.dart';
import 'package:ethiosolar_app/app/data/services/api_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/utils/media/media_type.dart';
import '../../../core/utils/store/user_session.dart';

class UpdateProfileController extends GetxController {
  late UserModel userModel;
  late TextEditingController fullNameController;
  late TextEditingController phoneNumberController;
  late TextEditingController jobDescriptionController;
  late TextEditingController cityController;
  late TextEditingController salespersonController;
  late TextEditingController passwordController;
  late FocusNode fullNameFocusNode;
  late FocusNode phoneNumberFocusNode;
  late FocusNode passwordFocusNode;
  late FocusNode addressFocusNode;
  late FocusNode cityFocusNode;
  late FocusNode salespersonFocusNode;

  RxBool isUpdateProfileLoading = false.obs;
  late GlobalKey<FormState> formKey;
  File? selectedImage;
  late ImagePickerUtil imagePickerUtil;
  final RxList<CityModel> cities = List<CityModel>.empty(growable: true).obs;
  var selectedCity = ''.obs;
  RxBool isCityLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      userModel = Get.arguments;
    }
    imagePickerUtil = ImagePickerUtil();
    formKey = GlobalKey<FormState>();
    fullNameController =
        TextEditingController(text: userModel.fullName ?? null);
    phoneNumberController =
        TextEditingController(text: userModel.phoneNumber ?? null);
    jobDescriptionController =
        TextEditingController(text: userModel.description);
    passwordController = TextEditingController(text: "");
    cityController = TextEditingController(text: userModel.country);
    salespersonController = TextEditingController(text: userModel.description);
    fullNameFocusNode = FocusNode();
    phoneNumberFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    addressFocusNode = FocusNode();
    cityFocusNode = FocusNode();
    salespersonFocusNode = FocusNode();

    fetchCities();
  }

  Future<void> fetchCities() async {
    try {
      ApiResponse? response = await ApiClient.instance.call(
        endPoint: ApiConstant.kgetCities,
        method: ApiMethod.GET,
      );
      if (response is BaseResponse) {
        CityResponseModel trainingResponseModel = CityResponseModel(
          cityList: CityModel.fromJsonList(response.results),
        );
        cities.addAll(trainingResponseModel.cityList ?? []);
        if (cities.isNotEmpty) {
          selectedCity.value = cities.first.id.toString();
        }
      }
    } finally {
      isCityLoading(false);
    }
  }

  Future<void> updateProfile() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    // if (selectedImage == null) {
    //   Get.snackbar("Error", "Please upload ID or Passport");
    //   return;
    // }
    isUpdateProfileLoading(true);
    if (selectedImage != null) {
      debugPrint("image is not empty");
      dio.FormData formDatas = dio.FormData.fromMap({
        "file": await dio.MultipartFile.fromFile(selectedImage!.path,
            filename: selectedImage!.path.split('/').last,
            contentType: MediaTypeUtil()
                .getMediaType(selectedImage!.path.split('/').last))
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
        try {
          UserRequestModel request = UserRequestModel(
            fullName: fullNameController.text,
            country: cityController.text,
            description: salespersonController.text,
            phoneNumber: phoneNumberController.text,
            password: passwordController.text,
            imageUrl: [
              responseUpload.results['filename'],
            ],
          );
          final userData = await UserSession.getUserData();
          final userId = userData?.id ?? 0;
          ApiResponse? response = await ApiClient.instance.call(
            endPoint: "${ApiConstant.kUpdateProfile}/$userId",
            method: ApiMethod.PUT,
            useToken: true,
            params: request.toJson(),
            mHeader: {"Content-Type": "application/json"},
          );
          if (response is BaseResponse) {
            UserModel data = UserModel.fromJson(response.results);
            await UserSession.setUserData(data);
            Get.back(result: data);
          }
        } finally {
          isUpdateProfileLoading(false);
        }
      }
    } else {
      debugPrint("image is not selected");
      try {
        // UserRequestModel request = UserRequestModel(
        //   fullName: fullNameController.text,
        //   country: selectedCity.value,
        //   description: salespersonController.text,
        //   phoneNumber: phoneNumberController.text,
        //   password: passwordController.text,
        // );
        final param = {
          "fullName": fullNameController.text,
          "country": selectedCity.value,
          "description": salespersonController.text,
          "phoneNumber": phoneNumberController.text,
          "password":
              passwordController.text == "" ? null : passwordController.text,
        };

        final userData = await UserSession.getUserData();
        final userId = userData?.id ?? 0;
        ApiResponse? response = await ApiClient.instance.call(
          endPoint: "${ApiConstant.kUpdateProfile}/$userId",
          method: ApiMethod.PUT,
          useToken: true,
          params: param,
          mHeader: {"Content-Type": "application/json"},
        );
        if (response is BaseResponse) {
          UserModel data = UserModel.fromJson(response.results);
          await UserSession.setUserData(data);
          Get.back(result: data);
        }
      } finally {
        isUpdateProfileLoading(false);
      }
    }
  }

  void selectImage() async {
    final image = await imagePickerUtil.getImage(source: ImageSource.gallery);
    selectedImage = image.$1;
  }
}
