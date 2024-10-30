import 'package:ethiosolar_app/app/data/models/address/delivery_address_model.dart';
import 'package:ethiosolar_app/app/data/models/address/delivery_address_request_model.dart';
import 'package:ethiosolar_app/app/data/models/address/delivery_address_response.dart';
import 'package:ethiosolar_app/app/data/services/api_client.dart';
import 'package:ethiosolar_app/app/data/services/api_constant.dart';
import 'package:ethiosolar_app/app/data/services/api_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/store/user_session.dart';

class AddressController extends GetxController {
  late TextEditingController addressController;
  late TextEditingController cityController;
  late TextEditingController nameController;
  late TextEditingController phoneNumberController;
  final isAddAddressLoading = false.obs;
  final isAddressLoading = false.obs;
  late String userId;
  final RxList<DeliveryAddressModel> deliveryAddress =
      List<DeliveryAddressModel>.empty(growable: true).obs;
  @override
  void onInit() {
    addressController = TextEditingController(text: "address");
    cityController = TextEditingController(text: "city");
    nameController = TextEditingController(text: "name");
    phoneNumberController = TextEditingController(text: "0900123456");
    super.onInit();
  }

  @override
  void onReady() async {
    await getDeliveryAddress();
    super.onReady();
  }

  Future<void> addAddress() async {
    isAddAddressLoading(true);

    userId = await UserSession.getUserId();

    try {
      final DeliveryAddressRequestModel request = DeliveryAddressRequestModel(
        address: addressController.text,
        city: cityController.text,
        phoneNumber: phoneNumberController.text,
        userId: int.parse(userId),
        contactName: nameController.text,
      );
      final ApiResponse? response = await ApiClient.instance.call(
        endPoint: ApiConstant.kDeliveryAddress,
        method: ApiMethod.POST,
        params: request.toJson(),
        useToken: true,
      );
      if (response is BaseResponse) {}
    } catch (e) {
    } finally {
      isAddAddressLoading(false);
    }
  }

  Future<void> getDeliveryAddress() async {
    isAddressLoading(true);
    try {
      userId = await UserSession.getUserId();

      final ApiResponse? response = await ApiClient.instance.call(
        endPoint: "${ApiConstant.kGetDeliveryAddress}/$userId",
        params: {},
        useToken: true,
      );
      if (response is BaseResponse) {
        final DeliveryAddressResponse deliveryAddressResponse =
            DeliveryAddressResponse(
          deliveryAddressList:
              DeliveryAddressModel.fromJsonList(response.results),
        );
        deliveryAddress.addAll(deliveryAddressResponse.deliveryAddressList);
      }
    } catch (e) {
    } finally {
      isAddressLoading(false);
    }
  }
}
