import 'package:ethiosolar_app/app/data/models/address/delivery_address_model.dart';
import 'package:ethiosolar_app/app/data/models/address/delivery_address_request_model.dart';
import 'package:ethiosolar_app/app/data/models/address/delivery_address_response.dart';
import 'package:ethiosolar_app/app/data/models/city/city_model.dart';
import 'package:ethiosolar_app/app/data/models/city/city_responnse_model.dart';
import 'package:ethiosolar_app/app/data/services/api_client.dart';
import 'package:ethiosolar_app/app/data/services/api_constant.dart';
import 'package:ethiosolar_app/app/data/services/api_response.dart';
import 'package:ethiosolar_app/app/core/utils/store/user_session.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryAddressController extends GetxController {
  RxList<DeliveryAddressModel> deliveryAddress =
      List<DeliveryAddressModel>.empty(growable: true).obs;
  RxBool isLoadingAddress = true.obs;
  RxBool isAddLoadingAddress = false.obs;
  RxBool isRemovingLoadingAddress = false.obs;
  late GlobalKey<FormState> formKey;

  late TextEditingController addressEditTextController;
  late TextEditingController cityEditTextController;
  late TextEditingController nameEditTextController;
  late TextEditingController phoneNumberEditTextController;

  //city typehead
  final cityController = TextEditingController();
  RxBool isCityLoading = false.obs;
  final RxList<CityModel> cities = List<CityModel>.empty(growable: true).obs;
  var selectedCity = ''.obs;

  @override
  void onInit() {
    formKey = GlobalKey<FormState>();
    addressEditTextController = TextEditingController();
    cityEditTextController = TextEditingController();
    nameEditTextController = TextEditingController();
    phoneNumberEditTextController = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() {
    getDeliveryAddress();
    fetchCities();

    super.onReady();
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

  void removeAddress(int addressId) async {
    isRemovingLoadingAddress(true);
    try {
      ApiResponse? response = await ApiClient.instance.call(
        endPoint: "${ApiConstant.kDeliveryAddress}/$addressId",
        method: ApiMethod.DELETE,
      );
      if (response is BaseResponse) {
        getDeliveryAddress();
      }
    } finally {
      isRemovingLoadingAddress(false);
    }
  }

  void addDeliveryAddress() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    isAddLoadingAddress(true);
    try {
      final DeliveryAddressRequestModel request = DeliveryAddressRequestModel(
        address: addressEditTextController.text,
        city: selectedCity.value,
        contactName: nameEditTextController.text,
        phoneNumber: phoneNumberEditTextController.text,
        userId: int.parse(
          await UserSession.getUserId(),
        ),
      );
      ApiResponse? response = await ApiClient.instance.call(
        method: ApiMethod.POST,
        endPoint: ApiConstant.kDeliveryAddress,
        params: request.toJson(),
      );
      if (response is BaseResponse) {
        getDeliveryAddress();
        clearTextFormField();
      }
    } finally {
      isAddLoadingAddress(false);
    }
  }

  Future<void> getDeliveryAddress() async {
    isLoadingAddress(true);
    deliveryAddress.clear();
    try {
      final id = await UserSession.getUserId();
      ApiResponse? response = await ApiClient.instance.call(
        endPoint: "${ApiConstant.kGetDeliveryAddress}/$id",
        method: ApiMethod.GET,
        useToken: true,
      );
      if (response is BaseResponse) {
        DeliveryAddressResponse deliveryAddressResponse =
            DeliveryAddressResponse(
          deliveryAddressList:
              DeliveryAddressModel.fromJsonList(response.results),
        );
        deliveryAddress.addAll(deliveryAddressResponse.deliveryAddressList);
      }
    } finally {
      isLoadingAddress(false);
    }
  }

  void clearTextFormField() {
    addressEditTextController.clear();
    cityEditTextController.clear();
    nameEditTextController.clear();
    phoneNumberEditTextController.clear();
  }
}
