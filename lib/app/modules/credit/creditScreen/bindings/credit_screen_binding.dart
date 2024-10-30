import 'package:get/get.dart';

import '../controllers/credit_screen_controller.dart';

class CreditScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreditScreenController>(
      () => CreditScreenController(),
    );
  }
}
