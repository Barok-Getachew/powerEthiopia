import 'package:get/get.dart';

import '../controllers/third_aboutus_controller.dart';

class ThirdAboutusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ThirdAboutusController>(
      () => ThirdAboutusController(),
    );
  }
}
