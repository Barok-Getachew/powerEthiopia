import 'package:ethiosolar_app/app/data/models/product/product_model.dart';
import 'package:ethiosolar_app/app/data/services/api_client.dart';
import 'package:ethiosolar_app/app/data/services/api_constant.dart';
import 'package:ethiosolar_app/app/data/services/api_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailController extends GetxController {
  int? productId;
  ProductModel? productModel;
  RxBool isLoading = false.obs;
  RxString selectedImageUrl = ''.obs;

  @override
  void onInit() {
    if (Get.arguments != null) {
      if (Get.arguments.runtimeType == ProductModel) {
        productModel = Get.arguments;
      } else if (Get.arguments.runtimeType == int) {
        productId = Get.arguments;
      }
    }
    super.onInit();
  }

  @override
  void onReady() async {
    if (productId != null) {
      await getProductById();
    }
    super.onReady();
  }

  Future<void> getProductById() async {
    isLoading(true);
    try {
      final ApiResponse? response = await ApiClient.instance.call(
        method: ApiMethod.GET,
        endPoint: "${ApiConstant.kgetProducts}/$productId",
        useToken: true,
      );
      if (response is BaseResponse) {
        debugPrint("response.results");
        productModel = ProductModel.fromJson(response.results);
      }
    } finally {
      isLoading(false);
    }
  }
}
