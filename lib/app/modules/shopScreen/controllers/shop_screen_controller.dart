import 'package:ethiosolar_app/app/data/models/product/product_request_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/product/product_model.dart';
import '../../../data/models/product/product_response_model.dart';
import '../../../data/services/api_client.dart';
import '../../../data/services/api_constant.dart';
import '../../../data/services/api_response.dart';

class ShopScreenController extends GetxController {
  final searchController = TextEditingController();
  late FocusNode searchFocusNode;
  final RxList<ProductModel> productList =
      List<ProductModel>.empty(growable: true).obs;
  final RxList<ProductModel> searchedProductList =
      List<ProductModel>.empty(growable: true).obs;
  RxList<ProductModel> newProductList =
      List<ProductModel>.empty(growable: true).obs;
  RxBool isProductLoading = true.obs;
  RxBool isSearchingProductLoading = true.obs;

  @override
  void onInit() {
    searchFocusNode = FocusNode();

    super.onInit();
  }

  @override
  void onReady() async {
    await getAllProduct();
    super.onReady();
  }

  @override
  void dispose() {
    searchFocusNode.dispose();
    super.dispose();
  }

  Future<void> getAllProduct() async {
    isProductLoading(true);
    newProductList.clear();
    productList.clear();
    try {
      final ApiResponse? response = await ApiClient.instance.call(
        endPoint: ApiConstant.kGetAllProduct,
        params: {},
        method: ApiMethod.GET,
        useToken: true,
      );
      if (response is BaseResponse) {
        final ProductResponseModel productResponseModel = ProductResponseModel(
          productList: ProductModel.fromJsonList(response.results),
        );
        productList.addAll(productResponseModel.productList);

        final List<ProductModel> newProductItemsTobeSorted = [];
        newProductItemsTobeSorted.addAll(productList);

        newProductItemsTobeSorted.sort(
          (a, b) => b.createdAt!.compareTo(a.createdAt!),
        );
        final reducedItems = newProductItemsTobeSorted.take(3);
        newProductList.addAll(reducedItems);
      }
    } finally {
      isProductLoading(false);
    }
  }

  Future<List<ProductModel>> searchProduct({required String searchTerm}) async {
    isSearchingProductLoading(true);
    searchedProductList.clear();
    try {
      final request = ProductRequestModel(searchTerm: searchTerm);
      final ApiResponse? response = await ApiClient.instance.call(
        endPoint: ApiConstant.kSearchProduct,
        method: ApiMethod.GET,
        useToken: true,
        params: request.toJson(),
      );
      if (response is BaseResponse) {
        ProductResponseModel productResponse = ProductResponseModel(
            productList: ProductModel.fromJsonList(response.results));

        searchedProductList.addAll(productResponse.productList);
      }
    } catch (e) {
    } finally {
      isSearchingProductLoading(false);
    }
    return searchedProductList;
  }
}
