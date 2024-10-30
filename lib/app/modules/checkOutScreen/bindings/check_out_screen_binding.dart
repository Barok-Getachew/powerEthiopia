import 'package:get/get.dart';

import '../../profileScreen/controllers/delivery_address_controller.dart';
import '../controllers/check_out_screen_controller.dart';

class CheckOutScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckOutScreenController>(
      () => CheckOutScreenController(),
    );
    Get.lazyPut<DeliveryAddressController>(
      () => DeliveryAddressController(),
    );
  }
}
