import 'package:ethiosolar_app/app/core/exports/app_exports.dart';
import 'package:ethiosolar_app/app/modules/credit/creditScreen/controllers/credit_screen_controller.dart';
import 'package:ethiosolar_app/app/modules/profileScreen/controllers/profile_screen_controller.dart';
import 'package:ethiosolar_app/app/modules/shopScreen/controllers/shop_screen_controller.dart';
import 'package:ethiosolar_app/app/modules/trainingCategoryScreen/controllers/training_screen_controller.dart';

class HomeController extends GetxController {
  var tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    Get.put(TrainingCategoryScreenController());
    Get.put(ShopScreenController());
    Get.put(CreditScreenController());
    Get.put(ProfileScreenController());
  }
}
