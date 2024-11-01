import 'package:ethiosolar_app/app/modules/cartScreen/controllers/cart_screen_controller.dart';
import 'package:get/get.dart';

import '../../modules/profileScreen/controllers/profile_screen_controller.dart';

class MainServices extends GetxService {
  @override
  void onInit() {
    super.onInit();
    initializeCart();
    dependencies();
  }

  void initializeCart() {
    Get.put(CartScreenController(), permanent: true);
  }

  void dependencies() {}
}
