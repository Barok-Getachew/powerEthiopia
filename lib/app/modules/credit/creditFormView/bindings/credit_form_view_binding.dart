import 'package:get/get.dart';

import '../controllers/credit_form_view_controller.dart';

class CreditFormViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreditFormViewController>(
      () => CreditFormViewController(),
    );
  }
}
