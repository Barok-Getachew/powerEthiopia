import 'package:get/get.dart';

import '../controllers/second_aboutus_controller.dart';

class SecondAboutusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SecondAboutusController>(
      () => SecondAboutusController(),
    );
  }
}
