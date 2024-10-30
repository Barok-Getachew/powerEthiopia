import 'package:ethiosolar_app/app/data/models/order/order_model.dart';
import 'package:get/get.dart';

class MyOrderDetailController extends GetxController {
  final count = 0.obs;
  OrderModel? order;
  @override
  void onInit() {
    if (Get.arguments != null) {
      order = Get.arguments;
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

  void increment() => count.value++;
}
