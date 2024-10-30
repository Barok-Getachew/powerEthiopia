import 'package:get/get.dart';

import '../controllers/courses_page_controller.dart';

class CoursesPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CoursesPageController>(
      () => CoursesPageController(),
    );
  }
}
