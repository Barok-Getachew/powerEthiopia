import 'package:ethiosolar_app/app/modules/profileScreen/controllers/profile_screen_controller.dart';
import 'package:get/get.dart';

import '../controllers/training_screen_controller.dart';

class TrainingCategoryScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrainingCategoryScreenController>(
      () => TrainingCategoryScreenController(),
    );
    Get.lazyPut<ProfileScreenController>(
      () => ProfileScreenController(),
    );
  }
}
