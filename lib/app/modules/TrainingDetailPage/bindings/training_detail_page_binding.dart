import 'package:get/get.dart';

import '../controllers/training_detail_page_controller.dart';

class TrainingDetailPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrainingDetailPageController>(
      () => TrainingDetailPageController(),
    );
  }
}
