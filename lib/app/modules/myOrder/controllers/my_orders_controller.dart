import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/order/order_model.dart';
import '../../../data/models/order/order_model_response.dart';
import '../../../data/services/api_client.dart';
import '../../../data/services/api_constant.dart';
import '../../../data/services/api_response.dart';
import '../../../core/utils/store/user_session.dart';

class MyOrdersController extends GetxController {
  final RxList<OrderModel> orderList =
      List<OrderModel>.empty(growable: true).obs;

  var isLoadingMyOrder = false.obs;
  @override
  void onInit() async {
    await getMyOrders();

    super.onInit();
  }

  Future<void> getMyOrders() async {
    isLoadingMyOrder(true);

    try {
      final String userId = await UserSession.getUserId();
      final ApiResponse? response = await ApiClient.instance.call(
        endPoint: "${ApiConstant.kGetMyOrders}/$userId",
        method: ApiMethod.GET,
      );
      if (response is BaseResponse) {
        final OrderModelResponse orderModelResponse = OrderModelResponse(
          orderList: OrderModel.fromJsonList(response.results),
        );
        orderList.addAll(orderModelResponse.orderList);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoadingMyOrder(false);
    }
  }
}
