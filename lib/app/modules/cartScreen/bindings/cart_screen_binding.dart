import 'package:ethiosolar_app/app/modules/myOrder/controllers/my_orders_controller.dart';
import 'package:get/get.dart';

class CartScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyOrdersController>(
      () => MyOrdersController(),
    );
  }
}
