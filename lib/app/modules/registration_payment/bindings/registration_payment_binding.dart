import 'package:get/get.dart';

import '../controllers/registration_payment_controller.dart';

class RegistrationPaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegistrationPaymentController>(
      () => RegistrationPaymentController(),
    );
  }
}
